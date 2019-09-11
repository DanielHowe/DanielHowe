
function OrbitEarth(input) {
	// Members
	var lastX = 0;
    var lastY = 0;
    var lastZ = 0;
    var position = new Vector3();
    
    // Methods
    this.getPosition = function() {
        return position;
    }
    
    this.updatePosition = function(x, y, z){
    	this.lastX = x;
    	this.lastY = y;
    	this.lastZ = z;
    }
    
}