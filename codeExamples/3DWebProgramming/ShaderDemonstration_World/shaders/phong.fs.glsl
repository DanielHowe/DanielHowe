// CST325 Graphics Programming Shadow Mapping
// Instructor: Michael Guerrero
// Students: Rogelio Moreno and Daniel Howe
// Filename: phong.fs.glsl
// Date: 2019-04-23
// Notes: Reference Source for PCF from:
//	         http://codeflow.org/entries/2013/feb/15/soft-shadow-mapping/

precision mediump float;

uniform sampler2D uAlbedoTexture;
uniform sampler2D uShadowTexture;
uniform mat4 uLightVPMatrix;
uniform vec3 uDirectionToLight;
uniform vec3 uCameraPosition;
uniform vec2 sampleSize;

varying vec2 vTexCoords;
varying vec3 vWorldNormal;
varying vec3 vWorldPosition;


float texture2DCompare(sampler2D depths, vec2 uv, float compare)
{	/**
	 References Source for PCF from:
	 http://codeflow.org/entries/2013/feb/15/soft-shadow-mapping/
	**/ 
    float depth = texture2D(depths, uv).r;
    return step(compare, depth);
}

float percentageCloserFilter(sampler2D depthMap, vec2 size, vec2 uv, float compare)
{ 	/**
	 Reference Source for PCF from:
	 http://codeflow.org/entries/2013/feb/15/soft-shadow-mapping/
	**/ 
	float result = 0.0;
	//int matrixSize = 2;
	for(int x =- 2; x <= 2; x++)
	{
		for(int y =- 2; y <= 2; y++)
		{
			vec2 off = vec2(x,y) / size;
			result += texture2DCompare(depthMap, uv + off, compare);
		}
	}
	return result / 25.0;
}


void main(void) {
    vec3 worldNormal01 = normalize(vWorldNormal);
    vec3 directionToEye01 = normalize(uCameraPosition - vWorldPosition);
    vec3 reflection01 = 2.0 * dot(worldNormal01, uDirectionToLight) * worldNormal01 - uDirectionToLight;

    float lambert = max(dot(worldNormal01, uDirectionToLight), 0.0);
    float specularIntensity = pow(max(dot(reflection01, directionToEye01), 0.0), 64.0);

    vec4 texColor = texture2D(uAlbedoTexture, vTexCoords);
    //vec4 shadowColor = texture2D(uShadowTexture, vTexCoords);

    //vec3 ambient = vec3(0.2, 0.2, 0.2) * texColor.rgb;
    // Brighten up the ambient light
    float brightnessFactor = 1.0;
    vec3 ambient = vec3(brightnessFactor, brightnessFactor, brightnessFactor) * texColor.rgb;

    vec3 diffuseColor = texColor.rgb * lambert;
    vec3 specularColor = vec3(1.0, 1.0, 1.0) * specularIntensity;
    vec3 finalColor = ambient + diffuseColor + specularColor;

    // todo #6
    // transform the world position into the lights clip space
    //Transform vWorldPosition into the light’s clip space (same as NDC, -1 to 1) and store your result in a vec4 variable called lightSpaceNDC.

  	vec4 lightSpaceNDC =  uLightVPMatrix * vec4(vWorldPosition, 1.0);

    // transform the clip space position into NDC (will already be in NDC for orthographic projection but we do it just in case)
    
    lightSpaceNDC = vec4(lightSpaceNDC.x/lightSpaceNDC.w, lightSpaceNDC.y/lightSpaceNDC.w, lightSpaceNDC.z/lightSpaceNDC.w, 1.0);

    // scale and bias the light-space NDC xy coordinates from [-1, 1] to [0, 1]
    //Next create a new vec2 variable called lightSpaceUV which has the same x and y components from lightSpaceNDC, only remapped to 0 to 1.

    vec2 lightSpaceUV = vec2((lightSpaceNDC.x + 1.0) * 0.5, (lightSpaceNDC.y + 1.0) * 0.5);

    // todo #8 scale and bias the light-space NDC z coordinate from [-1, 1] to [0, 1]
    //Remap lightSpaceNDC.z into the 0 to 1 range and store it in a float variable called lightDepth.  

    float lightDepth = ((lightSpaceNDC.z + 1.0) * 0.5);

    // use this as part of todo #10
    float bias = 0.004;

    // todo #7
    // Sample from the shadow map texture using the previously calculated lightSpaceUV
     vec4 shadowColor = texture2D(uShadowTexture, lightSpaceUV);

    // todo #9
    //gl_FragColor = vec4(testColor, 1.0); // remove this when you are ready to add shadows
   
    //gl_FragColor = vec4(shadowColor);

    //Set gl_FragColor = vec4(lightSpaceUV.x, lightSpaceUV.y, 0.0, 1.0)

    //gl_FragColor = vec4(lightSpaceUV.x, lightSpaceUV.y, 0.0,1.0);

    // gl_FragColor = shadowColor;

    //From todo 8
    //Then visualize this value: gl_FragColor = vec4(lightDepth, lightDepth, lightDepth, 1.0).

    gl_FragColor = vec4(lightDepth, lightDepth, lightDepth, 1.0);
	

    // Sample the depth of the closest position to the light (depth texture)
	//vec4 shadowColor = texture2D(?, ?);

	//     if ((current surface position depth to light) > (closest depth to light))
            // show only ambient light color
	//          } else {
	//                   show fully lit color
	//                  }

	//float percentageCloserFilter(sampler2D depthMap, vec2 size, vec2 uv, float compare)
    if (lightDepth > shadowColor.z + bias) 
    {
       // Show only ambient light
       gl_FragColor = vec4(ambient * percentageCloserFilter(uShadowTexture, vec2(2,2), vTexCoords, lightDepth), 1.0);
    } else 
    {
    	// Show fully lit color
        gl_FragColor = vec4(finalColor, 1.0);
    }
}
