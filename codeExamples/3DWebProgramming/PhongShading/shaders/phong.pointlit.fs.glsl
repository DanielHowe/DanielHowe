precision mediump float;

uniform vec3 uLightPosition;
uniform vec3 uCameraPosition;
uniform sampler2D uTexture;

varying vec2 vTexcoords;
varying vec3 vWorldNormal;
varying vec3 vWorldPosition;

void main(void) 
{
	 //gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
	
    // Compute albedo
    vec3 albedo = texture2D(uTexture, vTexcoords).rgb;

    
    // todo - diffuse contribution
    // 1. normalize the light direction and store in a separate variable
    vec3 vnLightPosition = normalize(uLightPosition - vWorldPosition);

    // Uncomment to visualize the normalization - note others
    // need to be disabled below
    //gl_FragColor = vec4(vnLightPosition, 1.0);
    //-----
    
    // 2. normalize the world normal and store in a separate variable
    vec3 nWorldDirection = normalize(vWorldNormal);
    
    // Uncomment to visualize the normalization - note others
    // need to be disabled below
    //gl_FragColor = vec4(nWorldDirection, 1.0);
    //-----
    
    // 3. calculate the lambert term
    // Useful reading on cosine and calculations
    // https://en.wikipedia.org/wiki/Lambert's_cosine_law
	float lambertTerm = dot(vnLightPosition, nWorldDirection);
	
	// Uncomment to visualize the normalization - note others
    // need to be disabled below
	//gl_FragColor = vec4(lambertTerm, lambertTerm, lambertTerm, 1.0);
	//-----
	
    // todo - specular contribution
    // 1. in world space, calculate the direction from the surface point to the eye (normalized)
    vec3 nEyeDirection = normalize(uCameraPosition - vWorldPosition);
    
     // Uncomment to visualize the normalization - note others
    // need to be disabled below
    //gl_FragColor = vec4(nEyeDirection, 1.0);
    //-----
    
    // 2. in world space, calculate the reflection vector (normalized)
    // https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/reflect.xhtml
    vec3 nReflectDirection = reflect(-vnLightPosition, nWorldDirection);
    
    // Uncomment to visualize the normalization - note others
    // need to be disabled below
	//gl_FragColor = vec4(nReflectDirection, 1.0);
	//-----
    
    // 3. calculate the phong term
    // p 400 Dunn and Parberry
    // https://en.wikibooks.org/wiki/GLSL_Programming/Vector_and_Matrix_Operations
    
    // Adjust for easier view-ability
    float specularPower = 64.0;
    
    // Compute specular intensity
    //float specularIntensity = pow(max(lambertTerm, 0.00), specularPower);
    //float specularIntensity = pow(max(dot(nWorldDirection, nReflectDirection), 0.00), specularPower);
    vec3 specularIntensity = vec3(.3, .3, .3) * albedo * pow(max(lambertTerm, 0.00), specularPower);
    
	// Uncomment to visualize the normalization - note others
    // need to be disabled below
	//gl_FragColor = vec4(specular, specular, specular, 1.0);
	//-----
    
    // todo - combine
    // 1. apply light and material interaction for diffuse value by using the texture color as the material
	//vec3 vAttenuatedLight = vec3(1.0, 1.0, 1.0);
	vec3 vAttenuatedLight = vec3(0.3, 0.3, 0.3);
	vAttenuatedLight *= albedo;
	
	// Uncomment to visualize the normalization - note others
    // need to be disabled below
	//gl_FragColor = vec4(vAttenuatedLight, 1.0);
	//-----
	
    // 2. apply light and material interaction for phong, assume phong material color is (0.3, 0.3, 0.3)

    vec3 diffuseColor = vec3(0.3, 0.3, 0.3);
    diffuseColor *= specularIntensity * nEyeDirection * albedo;

    //vec3 ambient = albedo * 0.1;
    vec3 ambient = vAttenuatedLight;

    vec3 finalColor = ambient + diffuseColor + specularIntensity;

	// Uncomment below for final phong shading rendering, once above has been computed
    gl_FragColor = vec4(finalColor, 1.0);

}
