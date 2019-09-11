// CST325 Graphics Programming Final Project
// Instructor: Michael Guerrero
// Students: Daniel Howe
// Filename: app.js
// Date: 2019-04-26
// Notes:

'use strict'

var gl;

var appInput = new Input();
var time = new Time();
var camera = new OrbitCamera(appInput);
var lightCamera = new Camera();

var earthGeometry = null;
var earthTexture = null;
var sunGeometry = null;
var sunTexture = null;
var moonGeometry = null;
var moonTexture = null;
var starGeometry = null;
var groundTexture = null;

var earthSunOrbitRadius = 10;
var earthPosition = new Matrix4();
var moonEarthOrbitRadius = 5;
var moonPosition = new Matrix4();

var projectionMatrix = new Matrix4();
var shadowProjectionMatrix = new Matrix4();

// Set the light at same position as Sun.
var lightPos = new Vector3(0, 0, 0);

var directionToLight = lightPos.clone().normalize();

var depthWriteProgram;
var phongShaderProgram;

// variables holding references to things we need to render to an offscreen texture
var fbo;
var renderTexture;
var renderBuffer;

window.onload = window['initializeAndStartRendering'];

var loadedAssets = {
    phongTextVS: null, phongTextFS: null,
    depthWriteVS: null, depthWriteFS: null,
    teapotJSON: null,
    marbleImage: null,
    starImage: null,
    earthImage: null,
    earthJSON: null,
    sunImage: null,
    sunJSON: null,
    moonImage: null,
    moonJSON: null
};

// -------------------------------------------------------------------------
// todo - use fetch instead of xmlhttprequest
function initializeAndStartRendering() {
    initGL();
    loadAssets(function() {
        createShaders(loadedAssets);
        createScene();
        createFrameBufferResources();

        updateAndRender();
    });
}

// -------------------------------------------------------------------------
function initGL(canvas) {
    var canvas = document.getElementById("webgl-canvas");

    try {
        gl = canvas.getContext("webgl");
        gl.canvasWidth = canvas.width;
        gl.canvasHeight = canvas.height;

        gl.enable(gl.DEPTH_TEST);
    } catch (e) {}

    if (!gl) {
        alert("Could not initialise WebGL, sorry :-(");
    }
}

// -------------------------------------------------------------------------
// Function to deliver promises
function fetchImage(url, callback) {
	return new Promise((resolve, reject) => {
		var image = new Image();
		image.onload = function () {
			resolve(image);
		};
		image.onerror = function() {
			reject('Unable to load ' + url);
		};
		image.src = url;
	});
};

// -------------------------------------------------------------------------
// Function to loadAssets once available
function loadAssets(onLoadedCB) {
    var filePromises = [
        fetch('./shaders/phong.vs.glsl').then((response) => { return response.text(); }),
        fetch('./shaders/phong.fs.glsl').then((response) => { return response.text(); }),
        fetch('./data/teapot.json').then((response) => { return response.json(); }),
        fetch('./shaders/depth-write.vs.glsl').then((response) => { return response.text(); }),
        fetch('./shaders/depth-write.fs.glsl').then((response) => { return response.text(); }),
        fetchImage('./data/marble.jpg'),
        fetchImage('./data/starfield-2276843_960_720.jpg'),
        fetchImage('./data/earth.jpg'),
        fetch('./data/sphere.json').then((response) => { return response.json(); }),
        fetchImage('./data/sun.jpg'),
        fetchImage('./data/moon.png'),
    ];

    Promise.all(filePromises).then(function(values) {
        // Assign loaded data to our named variables
        loadedAssets.phongTextVS = values[0];
        loadedAssets.phongTextFS = values[1];
        loadedAssets.teapotJSON = values[2];
        loadedAssets.depthWriteVS = values[3];
        loadedAssets.depthWriteFS = values[4];
        loadedAssets.marbleImage = values[5];
        loadedAssets.starImage = values[6];
        loadedAssets.earthImage = values[7];
        loadedAssets.earthJSON = values[8];
        loadedAssets.sunImage = values[9];
        loadedAssets.sunJSON = values[8];
        loadedAssets.moonImage = values[10];
        loadedAssets.moonJSON = values[8];
    }).catch(function(error) {
        console.error(error.message);
    }).finally(function() {
        onLoadedCB();
    });
}

// -------------------------------------------------------------------------
function createShaders(loadedAssets) {
    depthWriteProgram = createCompiledAndLinkedShaderProgram(loadedAssets.depthWriteVS, loadedAssets.depthWriteFS);

    depthWriteProgram.attributes = {
        vertexPositionAttribute: gl.getAttribLocation(depthWriteProgram, "aVertexPosition"),
    };

    depthWriteProgram.uniforms = {
        worldMatrixUniform:      gl.getUniformLocation(depthWriteProgram, "uWorldMatrix"),
        viewMatrixUniform:       gl.getUniformLocation(depthWriteProgram, "uViewMatrix"),
        projectionMatrixUniform: gl.getUniformLocation(depthWriteProgram, "uProjectionMatrix"),
    };

    phongShaderProgram = createCompiledAndLinkedShaderProgram(loadedAssets.phongTextVS, loadedAssets.phongTextFS);

    phongShaderProgram.attributes = {
        vertexPositionAttribute: gl.getAttribLocation(phongShaderProgram, "aVertexPosition"),
        vertexTexCoordsAttribute: gl.getAttribLocation(phongShaderProgram, "aTexCoords"),
        vertexNormalsAttribute: gl.getAttribLocation(phongShaderProgram, "aNormal"),
    };

    phongShaderProgram.uniforms = {
        worldMatrixUniform: gl.getUniformLocation(phongShaderProgram, "uWorldMatrix"),
        viewMatrixUniform: gl.getUniformLocation(phongShaderProgram, "uViewMatrix"),
        projectionMatrixUniform: gl.getUniformLocation(phongShaderProgram, "uProjectionMatrix"),
        directionToLightUniform: gl.getUniformLocation(phongShaderProgram, "uDirectionToLight"),
        lightVPMatrixUniform: gl.getUniformLocation(phongShaderProgram, "uLightVPMatrix"),
        cameraPositionUniform: gl.getUniformLocation(phongShaderProgram, "uCameraPosition"),
        albedoTextureUniform: gl.getUniformLocation(phongShaderProgram, "uAlbedoTexture"),
        shadowTextureUniform: gl.getUniformLocation(phongShaderProgram, "uShadowTexture")
    };
}

// -------------------------------------------------------------------------
function createScene() {
	// First, there was Earth <------
    earthGeometry = new WebGLGeometryJSON(gl, phongShaderProgram);
    earthGeometry.create(loadedAssets.earthJSON, loadedAssets.earthImage);
    earthGeometry.worldMatrix.scale(.02, .02, .02);

	// Update the location of Earth
    earthPosition = new Vector3(earthSunOrbitRadius, 0, 0);
    earthGeometry.worldMatrix.translate(earthPosition);
    
    // Then the sun <--------
    sunGeometry = new WebGLGeometryJSON(gl, phongShaderProgram);
    sunGeometry.create(loadedAssets.earthJSON, loadedAssets.sunImage);
    sunGeometry.worldMatrix.scale(.03, .03, .03);
    
    // Then the moon <-------
    moonGeometry = new WebGLGeometryJSON(gl, phongShaderProgram);
    moonGeometry.create(loadedAssets.earthJSON, loadedAssets.moonImage);
    moonGeometry.worldMatrix.scale(.01, .01, .01);
    
    moonPosition = new Vector3(earthSunOrbitRadius, 0, 0);
    moonGeometry.worldMatrix.translate(earthSunOrbitRadius + moonEarthOrbitRadius, 0, 0);

	// Then the stars <-----
    starGeometry = new WebGLGeometryQuad(gl, phongShaderProgram);
    starGeometry.create(loadedAssets.starImage);
    starGeometry.worldMatrix.scale(10.0, 10.0, 10.0);
    
    starGeometry.worldMatrix.translate(100, 0, 0);
}

// -------------------------------------------------------------------------
function createFrameBufferResources() {
    var dimension = 2048;
    var width = dimension, height = dimension;

    // This lets WebGL know we want to use these extensions (not default in WebGL1)
    gl.getExtension("OES_texture_float");
    gl.getExtension("OES_texture_float_linear");

    // create and set up the texture that will be rendered into
    renderTexture = gl.createTexture();
    gl.bindTexture(gl.TEXTURE_2D, renderTexture);
    gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, width, height, 0, gl.RGBA, gl.FLOAT, null);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);

    // create an alternate frame buffer that we will render depth into (works in conjunction with the texture we just created)
    fbo = gl.createFramebuffer();
    gl.bindFramebuffer(gl.FRAMEBUFFER, fbo);
    gl.framebufferTexture2D(gl.FRAMEBUFFER, gl.COLOR_ATTACHMENT0, gl.TEXTURE_2D, renderTexture, 0);
    fbo.width = fbo.height = dimension;

    renderBuffer = gl.createRenderbuffer();
    gl.bindRenderbuffer(gl.RENDERBUFFER, renderBuffer);

    gl.renderbufferStorage(gl.RENDERBUFFER, gl.DEPTH_COMPONENT16, width, height);
    gl.framebufferRenderbuffer(gl.FRAMEBUFFER, gl.DEPTH_ATTACHMENT, gl.RENDERBUFFER, renderBuffer);

    gl.bindTexture(gl.TEXTURE_2D, null);
    gl.bindFramebuffer(gl.FRAMEBUFFER, null);
    gl.bindRenderbuffer(gl.RENDERBUFFER, null);

    checkFrameBufferStatus();
}

// -------------------------------------------------------------------------
function updateAndRender() {
    requestAnimationFrame(updateAndRender);

    var aspectRatio = gl.canvasWidth / gl.canvasHeight;
    time.update();
    
    updatePlanetaryPositions();

    var yaw = 0, pitch = 0;
    if (appInput.a) yaw -= 1;
    if (appInput.d) yaw += 1;
    if (appInput.w) pitch -= 1;
    if (appInput.s) pitch += 1;

    var yawMatrix = new Matrix3().setRotationY(45.0 * time.deltaTime * yaw);
    var pitchMatrix = new Matrix3().setRotationX(45.0 * time.deltaTime * pitch);
    var rotationMatrix = pitchMatrix.clone().multiplyRightSide(yawMatrix);
    rotationMatrix.multiplyVector(directionToLight);
    rotationMatrix.multiplyVector(lightPos);

    var lightTarget = new Vector3(0, 0, 0);
    var up = new Vector3(0, 1, 0);

    // Todo - Set up a camera that points in the direction of the light at a
    // reasonably close position such that the scene will be in the view volume.
    // We will set up the view volume boundaries with an orthographics projection.
    // lightCamera.cameraWorldMatrix.setLookAt(?, ?, ?);
    // lightCamera.cameraWorldMatrix.setLookAt(eyePos, targetPos, worldUp);
    var eyePos = new Vector3();
    eyePos = lightPos;

    var targetPos = new Vector3();
    targetPos = lightTarget;

    var worldUp = new Vector3();
    worldUp = up;

    lightCamera.cameraWorldMatrix.setLookAt(eyePos,targetPos,worldUp);

    camera.update(time.deltaTime);

    // render scene depth to texture ##################

    gl.bindFramebuffer(gl.FRAMEBUFFER, fbo);
    gl.bindRenderbuffer(gl.RENDERBUFFER, renderBuffer);

    gl.clearColor(0, 1, 0, 1.0);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

    // specify what portion of the canvas we want to draw to (all of it, full width and height)
    gl.viewport(0, 0, fbo.width, fbo.height);

    // this.setOrthographic = function(left, right, top, bottom, near, far)
    shadowProjectionMatrix.setOrthographic(-10, 10, 10, -10, 1.0, 20);
    gl.disable(gl.CULL_FACE);
    starGeometry.render(lightCamera, shadowProjectionMatrix, depthWriteProgram);
    earthGeometry.render(lightCamera, shadowProjectionMatrix, depthWriteProgram);
    sunGeometry.render(lightCamera, shadowProjectionMatrix, depthWriteProgram);
	moonGeometry.render(lightCamera, shadowProjectionMatrix, depthWriteProgram);

    gl.bindFramebuffer(gl.FRAMEBUFFER, null);
    gl.bindRenderbuffer(gl.RENDERBUFFER, null);

    // render scene normally and use the depth texture to apply shadows ################

    // specify what portion of the canvas we want to draw to (all of it, full width and height)
    gl.viewport(0, 0, gl.canvasWidth, gl.canvasHeight);

    // this is a new frame so let's clear out whatever happened last frame
    //gl.clearColor(0.707, 0.707, 1, 1.0);
    gl.clearColor(0, 0, 0, 1.0);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

    var lightVPMatrix = shadowProjectionMatrix.clone().multiplyRightSide(lightCamera.getViewMatrix());

    gl.useProgram(phongShaderProgram);
    var uniforms = phongShaderProgram.uniforms;
    var cameraPosition = camera.getPosition();

    gl.uniform3f(uniforms.directionToLightUniform, directionToLight.x, directionToLight.y, directionToLight.z);
    gl.uniform3f(uniforms.cameraPositionUniform, cameraPosition.x, cameraPosition.y, cameraPosition.z);

    gl.uniformMatrix4fv(uniforms.lightVPMatrixUniform, false, lightVPMatrix.transpose().elements);

    projectionMatrix.setPerspective(45, aspectRatio, 0.1, 1000);
    gl.enable(gl.CULL_FACE);
    starGeometry.render(camera, projectionMatrix, phongShaderProgram, renderTexture);
    earthGeometry.render(camera, projectionMatrix, phongShaderProgram, renderTexture);
    sunGeometry.render(camera, projectionMatrix, phongShaderProgram, renderTexture);
	moonGeometry.render(camera, projectionMatrix, phongShaderProgram, renderTexture);

    // var spector = new SPECTOR.Spector();
    //You can then display the embedded UI directly in your page:

    // spector.displayUI();

}
function updatePlanetaryPositions(){
	//Here we are rotating the planets about the sun
	//console.log("Time since start: "+time.secondsElapsedSinceStart);
	//console.log(Math.sin(time.secondsElapsedSinceStart));
	
	var rotation = new Matrix4().setRotationY(Math.sin(time.secondsElapsedSinceStart) * .09);
	//var rotation = new Matrix3().setRotationZ(Math.sin(time.secondsElapsedSinceStart));
	
	// Rotate the Earth
    earthGeometry.worldMatrix.multiplyRightSide(rotation);

	// Rotate the Moon 
    moonGeometry.worldMatrix.multiplyRightSide(rotation);
    
    // Rotate the SUN
    sunGeometry.worldMatrix.multiplyRightSide(rotation);
}
