/*
Student: Daniel Howe
Professor: Michael Guerrero
Assignment: Module 6 + part 2
Date: 2019-04-16
*/


'use strict'

var gl;

var appInput = new Input();
var time = new Time();
var camera = new OrbitCamera(appInput);

var sphereGeometry = null; // this will be created after loading from a file
var barrelGeometry = null;
var groundGeometry = null;

var lightRotationRadius = 3.0; // this is the distance the light should rotate around sphere

var projectionMatrix = new Matrix4();
var lightPosition = new Vector3(4.5, 1.5, 0);

// the shader that will be used by each piece of geometry (they could each use their own shader but in this case it will be the same)
var phongShaderProgram;

// auto start the app when the html page is ready
window.onload = window['initializeAndStartRendering'];

// we need to asynchronously fetch files from the "server" (your local hard drive)
var loadedAssets = {
    phongTextVS: null, phongTextFS: null,
    vertexColorVS: null, vertexColorFS: null,
    sphereJSON: null,
    barrelJSON: null,
    marbleImage: null,
    barrelImage: null,
    crackedMudImage: null
};

// -------------------------------------------------------------------------
function initializeAndStartRendering() {
    initGL();
    loadAssets(function() {
        createShaders(loadedAssets);
        createScene();

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
function loadAssets(onLoadedCB) {
    var filePromises = [
        fetch('./shaders/phong.vs.glsl').then((response) => { return response.text(); }),
        fetch('./shaders/phong.pointlit.fs.glsl').then((response) => { return response.text(); }),
        fetch('./data/sphere.json').then((response) => { return response.json(); }),
        fetch('./data/barrel.json').then((response) => { return response.json(); }),
        loadImage('./data/marble.jpg'),
        loadImage('./data/barrel.png'),
        loadImage('./data/crackedMud.png')
    ];

    Promise.all(filePromises).then(function(values) {
        // Assign loaded data to our named variables
        loadedAssets.phongTextVS = values[0];
        loadedAssets.phongTextFS = values[1];
        loadedAssets.sphereJSON = values[2];
        loadedAssets.barrelJSON = values[3];
        loadedAssets.marbleImage = values[4];
        loadedAssets.barrelImage = values[5];
        loadedAssets.crackedMudImage = values[6];
    }).catch(function(error) {
        console.error(error.message);
    }).finally(function() {
        onLoadedCB();
    });
}

// -------------------------------------------------------------------------
function createShaders(loadedAssets) {
    phongShaderProgram = createCompiledAndLinkedShaderProgram(loadedAssets.phongTextVS, loadedAssets.phongTextFS);

    phongShaderProgram.attributes = {
        vertexPositionAttribute: gl.getAttribLocation(phongShaderProgram, "aVertexPosition"),
        vertexNormalsAttribute: gl.getAttribLocation(phongShaderProgram, "aNormal"),
        vertexTexcoordsAttribute: gl.getAttribLocation(phongShaderProgram, "aTexcoords")
    };

    phongShaderProgram.uniforms = {
        worldMatrixUniform: gl.getUniformLocation(phongShaderProgram, "uWorldMatrix"),
        viewMatrixUniform: gl.getUniformLocation(phongShaderProgram, "uViewMatrix"),
        projectionMatrixUniform: gl.getUniformLocation(phongShaderProgram, "uProjectionMatrix"),
        lightPositionUniform: gl.getUniformLocation(phongShaderProgram, "uLightPosition"),
        cameraPositionUniform: gl.getUniformLocation(phongShaderProgram, "uCameraPosition"),
        textureUniform: gl.getUniformLocation(phongShaderProgram, "uTexture"),
    };
}

// -------------------------------------------------------------------------
function createScene() {
    groundGeometry = new WebGLGeometryQuad(gl, phongShaderProgram);
    groundGeometry.create(loadedAssets.crackedMudImage);
	
	// Put the sphere in the scene, scale and translate to position
    sphereGeometry = new WebGLGeometryJSON(gl, phongShaderProgram);
    sphereGeometry.create(loadedAssets.sphereJSON, loadedAssets.marbleImage);

    // Scaled it down so that the diameter is 3, (starts at 100)
    var scale = new Matrix4().scale(0.03, 0.03, 0.03);

    sphereGeometry.worldMatrix.identity();
    sphereGeometry.worldMatrix.multiplyRightSide(scale);

    // raise it by the radius to make it sit on the ground
    sphereGeometry.worldMatrix.translate(0, 1.5, 0);
    
    // Put the barrel in the scene, scale and translate
    barrelGeometry = new WebGLGeometryJSON(gl, phongShaderProgram);
    barrelGeometry.create(loadedAssets.barrelJSON, loadedAssets.barrelImage);

	scale = new Matrix4().scale(0.3, 0.3, 0.3);
	
    barrelGeometry.worldMatrix.identity();
    barrelGeometry.worldMatrix.multiplyRightSide(scale);
	
    // translate according to instructions
    barrelGeometry.worldMatrix.translate(-5.0, 2.0, -5.0);
    
    console.log("Extra credit appreciated!");
}

// -------------------------------------------------------------------------
function updateAndRender() {
    requestAnimationFrame(updateAndRender);

    var aspectRatio = gl.canvasWidth / gl.canvasHeight;

    // todo 
    // add keyboard controls for changing light direction here
	updateLightPosition();
	
	// added to rotate the light around the sphere
	rotateLightPosition();
	
    time.update();
    camera.update(time.deltaTime);

    // specify what portion of the canvas we want to draw to (all of it, full width and height)
    gl.viewport(0, 0, gl.canvasWidth, gl.canvasHeight);

    // this is a new frame so let's clear out whatever happened last frame
    gl.clearColor(0.707, 0.707, 1, 1.0);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

    gl.useProgram(phongShaderProgram);
    var uniforms = phongShaderProgram.uniforms;
    var cameraPosition = camera.getPosition();
    gl.uniform3f(uniforms.lightPositionUniform, lightPosition.x, lightPosition.y, lightPosition.z);
    gl.uniform3f(uniforms.cameraPositionUniform, cameraPosition.x, cameraPosition.y, cameraPosition.z);

    projectionMatrix.setPerspective(45, aspectRatio, 0.1, 1000);
    groundGeometry.render(camera, projectionMatrix, phongShaderProgram);
    sphereGeometry.render(camera, projectionMatrix, phongShaderProgram);
    barrelGeometry.render(camera, projectionMatrix, phongShaderProgram);
}

function rotateLightPosition()
{
	// light position is updated to rotate around the sphere
	lightPosition = new Vector3(Math.cos(time.secondsElapsedSinceStart) * lightRotationRadius, lightRotationRadius, Math.sin(time.secondsElapsedSinceStart) * lightRotationRadius);
}

function updateLightPosition()
{
	// determine current position
	var increment = 1/3;
	
	// Detect if up key pressed
	if (appInput.up == true)
	{
		lightPosition.y += increment;
	}
	
	// Detect if down key pressed
	if (appInput.down == true)
	{
		lightPosition.y -= increment;
	}
	
	// Detect if left key pressed
	if (appInput.left == true)
	{
		lightPosition.x += increment;
	}
	
	// Detect if right key pressed
	if (appInput.right == true)
	{
		lightPosition.x -= increment;
	}
	
	// Detect if a key pressed
	if (appInput.a == true)
	{
		lightPosition.z -= increment;
	}
	
	// Detect if a key pressed
	if (appInput.w == true)
	{
		lightPosition.z += increment;
	}
}
