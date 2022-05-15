import { Mat4 } from './math.js';
import { Parser } from './parser.js';
import { Scene } from './scene.js';
import { Renderer } from './renderer.js';
import { TriangleMesh } from './trianglemesh.js';
// DO NOT CHANGE ANYTHING ABOVE HERE

////////////////////////////////////////////////////////////////////////////////
// TODO: Implement createCube, createSphere, computeTransformation, and shaders
////////////////////////////////////////////////////////////////////////////////

// Example two triangle quad
const quad = {
  positions: [-1, -1, -1, 1, -1, -1, 1, 1, -1, -1, -1, -1, 1,  1, -1, -1,  1, -1], // 6
  normals: [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], // 6
  uvCoords: [0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1] // 4
}

const cube = {
  positions: [-1,-1,1,    1,-1,1,   1,1,1,
              -1,-1,1,    1,1,1,   -1,1,1,
               1,-1,1,    1,-1,-1,  1,1,-1,
               1,-1,1,    1,1,-1,   1,1,1,
               1,-1,-1,  -1,-1,-1, -1,1,-1,
               1,-1,-1,  -1,1,-1,   1,1,-1,
              -1,-1,-1,  -1,-1,1,  -1,1,1,
              -1,-1,-1,  -1,1,1,   -1,1,-1,
              -1,1,1,     1,1,1,    1,1,-1,
              -1,1,1,     1,1,-1,  -1,1,-1,
               1,-1,1,   -1,-1,-1,  1,-1,-1,
               1,-1,1,   -1,-1, 1, -1,-1, -1],

  normals: [0,0,1,    0,0,1,   0,0,1,
            0,0,1,    0,0,1,   0,0,1,
            1,0,0,    1,0,0,   1,0,0,
            1,0,0,    1,0,0,   1,0,0,
            0,0,-1,   0,0,-1,   0,0,-1,
            0,0,-1,    0,0,-1,   0,0,-1,
            -1,0,0,    -1,0,0,   -1,0,0,
            -1,0,0,    -1,0,0,   -1,0,0,
            0,1,0,    0,1,0,   0,1,0,
            0,1,0,    0,1,0,   0,1,0,
            0,-1,0,    0,-1,0,   0,-1,0,
            0,-1,0,    0,-1,0,   0,-1,0],

  uvCoords: [0, 0, 1, 0, 1, 1,
             0, 0, 1, 1, 0, 1,
             1, 0, 0, 0, 0, 1,
             1, 0, 0, 1, 1, 1,
             0, 0, 1, 0, 1, 1,
             0, 0, 1, 1, 0, 1,
             1, 0, 0, 0, 0, 1,
             1, 0, 0, 1, 1, 1,
             0, 1, 1, 1, 0, 1,
             0, 1, 0, 1, 1, 1,
             1, 0, 1, 0, 0, 0,
             1, 0, 0, 0, 1, 0]
}

TriangleMesh.prototype.createCube = function() {

  // TODO: populate unit cube vertex positions, normals, and uv coordinates
  this.positions = cube.positions;
  this.normals = cube.normals;
  this.uvCoords = cube.uvCoords;
}


TriangleMesh.prototype.createSphere = function(numStacks, numSectors) {
    // code taken from http://www.songho.ca/opengl/gl_sphere.html
    let vertices = [];
    let normals = [];
    let texCoords = [];


    let radius = 1;
    let x, y, z, xy;                              // vertex position
    let nx, ny, nz, lengthInv = 1.0 / radius;    // vertex normal
    let s, t;                                     // vertex texCoord

    let sectorStep = 2 * Math.PI / numSectors;
    let stackStep = Math.PI / numStacks;
    let sectorAngle, stackAngle;

    for(let i = 0; i <= numStacks; ++i)
    {
        stackAngle = Math.PI / 2 - i * stackStep;        // starting from pi/2 to -pi/2
        xy = radius * Math.cos(stackAngle);             // r * cos(u)
        z = radius * Math.sin(stackAngle);              // r * sin(u)

        // add (sectorCount+1) vertices per stack
        // the first and last vertices have same position and normal, but different tex coords
        for(let j = 0; j <= numSectors; ++j)
        {
            sectorAngle = j * sectorStep;           // starting from 0 to 2pi
            // vertex position (x, y, z)
            x = xy * Math.cos(sectorAngle);             // r * cos(u) * cos(v)
            y = xy * Math.sin(sectorAngle);             // r * cos(u) * sin(v)
            vertices.push(x);
            vertices.push(y);
            vertices.push(z);

            // normalized vertex normal (nx, ny, nz)
            nx = x * lengthInv;
            ny = y * lengthInv;
            nz = z * lengthInv;
            normals.push(nx);
            normals.push(ny);
            normals.push(nz);

            // vertex tex coord (s, t) range between [0, 1]
            s = j / numSectors;
            t = i / numStacks;
            texCoords.push(s);
            texCoords.push(t);
        }
    }

// generate CCW index list of sphere triangles
// k1--k1+1
// |  / |
// | /  |
// k2--k2+1
    let indices = [];
    let lineIndices = [];

    let k1, k2;
    for(let i = 0; i < numStacks; ++i)
    {
        k1 = i * (numSectors + 1);     // beginning of current stack
        k2 = k1 + numSectors + 1;      // beginning of next stack

        for(let j = 0; j < numSectors; ++j, ++k1, ++k2)
        {
            // 2 triangles per sector excluding first and last stacks
            // k1 => k2 => k1+1
            if(i !== 0)
            {
                indices.push(k1);
                indices.push(k2);
                indices.push(k1 + 1);
            }

            // k1+1 => k2 => k2+1
            if(i !== (numStacks - 1))
            {
                indices.push(k1 + 1);
                indices.push(k2);
                indices.push(k2 + 1);
            }

            // store indices for lines
            // vertical lines for all stacks, k1 => k2
            lineIndices.push(k1);
            lineIndices.push(k2);
            if(i !== 0)  // horizontal lines except 1st stack, k1 => k+1
            {
                lineIndices.push(k1);
                lineIndices.push(k1 + 1);
            }
        }
    }

    // TODO: populate unit sphere vertex positions, normals, uv coordinates, and indices

    this.positions = vertices;
    this.normals = normals;
    this.uvCoords = texCoords;
    this.indices = indices;



    /*

  this.positions = quad.positions.slice(0, 9).map(p => p * 0.5);
  this.normals = quad.normals.slice(0, 9);
  this.uvCoords = quad.uvCoords.slice(0, 6);
  this.indices = [0, 1, 2];

     */
}

Scene.prototype.computeTransformation = function(transformSequence) {
  // TODO: go through transform sequence and compose into overallTransform
    let o = new Float32Array(16);
    o[0] = 1; o[5] = 1; o[10] = 1; o[15] = 1;
    /*
    for (let i = 0; i < transformSequence.length; i++) {
        if(transformSequence[i][0] === 'T') {
            let toMultiply = new Float32Array(16);
            toMultiply[3] = transformSequence[i][1]; toMultiply[7] = transformSequence[i][2]; toMultiply[11] = transformSequence[i][3];
            toMultiply[0] = 1; toMultiply[5] = 1; toMultiply[10] = 1; toMultiply[15] = 1;
            o = multiply(o, toMultiply);
        }
        if(transformSequence[i][0] === 'Rx') {
            let theta = transformSequence[i][1];
            let toMultiply = new Float32Array(16);
            toMultiply[2] = 1;
            toMultiply[4] = Math.cos(theta * (Math.PI/180)); toMultiply[5] = Math.sin(theta * (Math.PI/180));
            toMultiply[8] = -Math.sin(theta * (Math.PI/180)); toMultiply[9] = Math.cos(theta * (Math.PI/180));
            toMultiply[15] = 1;
            o = multiply(o, toMultiply);
        }
        if(transformSequence[i][0] === 'Ry') {
            let theta = transformSequence[i][1];
            let toMultiply = new Float32Array(16);
            toMultiply[6] = 1;
            toMultiply[0] = -Math.sin(theta * (Math.PI/180)); toMultiply[1] = Math.cos(theta * (Math.PI/180));
            toMultiply[8] = Math.cos(theta * (Math.PI/180)); toMultiply[9] = Math.sin(theta * (Math.PI/180));
            toMultiply[15] = 1;
            o = multiply(o, toMultiply);
        }
        if(transformSequence[i][0] === 'Rz') {
            let theta = transformSequence[i][1];
            let toMultiply = new Float32Array(16);
            toMultiply[10] = 1;
            toMultiply[0] = Math.cos(theta * (Math.PI/180)); toMultiply[1] = Math.sin(theta * (Math.PI/180));
            toMultiply[4] = -Math.sin(theta * (Math.PI/180)); toMultiply[5] = Math.cos(theta * (Math.PI/180));
            toMultiply[15] = 1;
            o = multiply(o, toMultiply);
        }
        if(transformSequence[i][0] === 'S') {
            let toMultiply = new Float32Array(16);
            toMultiply[0] = transformSequence[i][1]; toMultiply[5] = transformSequence[i][2]; toMultiply[10] = transformSequence[i][3]; toMultiply[15] = 1;
            o = multiply(o, toMultiply);
        }
    }
     */

  return o;
}

function multiply(a, b) {
    let out = new Float32Array(16);
    const a00 = a[0], a01 = a[1], a02 = a[2], a03 = a[3];
    const a10 = a[4], a11 = a[5], a12 = a[6], a13 = a[7];
    const a20 = a[8], a21 = a[9], a22 = a[10], a23 = a[11];
    const a30 = a[12], a31 = a[13], a32 = a[14], a33 = a[15];
    let b0 = b[0], b1 = b[1], b2 = b[2], b3 = b[3];
    out[0] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
    out[1] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
    out[2] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
    out[3] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
    b0 = b[4]; b1 = b[5]; b2 = b[6]; b3 = b[7];
    out[4] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
    out[5] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
    out[6] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
    out[7] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
    b0 = b[8]; b1 = b[9]; b2 = b[10]; b3 = b[11];
    out[8] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
    out[9] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
    out[10] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
    out[11] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
    b0 = b[12]; b1 = b[13]; b2 = b[14]; b3 = b[15];
    out[12] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
    out[13] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
    out[14] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
    out[15] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
    return out;
}

Renderer.prototype.VERTEX_SHADER = `
precision mediump float;
attribute vec3 position, normal;
attribute vec2 uvCoord;
uniform vec3 lightPosition;
uniform mat4 projectionMatrix, viewMatrix, modelMatrix;
uniform mat3 normalMatrix;
varying vec2 vTexCoord;

// TODO: implement vertex shader logic below

varying vec3 temp;

void main() {
  temp = vec3(position.x, normal.x, uvCoord.x);
  vTexCoord = uvCoord;
  gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
`;

Renderer.prototype.FRAGMENT_SHADER = `
precision mediump float;
uniform vec3 ka, kd, ks, lightIntensity;
uniform float shininess;
uniform sampler2D uTexture;
uniform bool hasTexture;
varying vec2 vTexCoord;

// TODO: implement fragment shader logic below

varying vec3 temp;

void main() {
  gl_FragColor = vec4(temp, 1.0);
}
`;

////////////////////////////////////////////////////////////////////////////////
// EXTRA CREDIT: change DEF_INPUT to create something interesting!
////////////////////////////////////////////////////////////////////////////////
const DEF_INPUT = [
  "c,myCamera,perspective,5,5,5,0,0,0,0,1,0;",
  "l,myLight,point,0,5,0,2,2,2;",
  "p,unitCube,cube;",
  "p,unitSphere,sphere,20,20;",
  "m,redDiceMat,0.3,0,0,0.7,0,0,1,1,1,15,dice.jpg;",
  "m,grnDiceMat,0,0.3,0,0,0.7,0,1,1,1,15,dice.jpg;",
  "m,bluDiceMat,0,0,0.3,0,0,0.7,1,1,1,15,dice.jpg;",
  "m,globeMat,0.3,0.3,0.3,0.7,0.7,0.7,1,1,1,5,globe.jpg;",
  "o,rd,unitCube,redDiceMat;",
  "o,gd,unitCube,grnDiceMat;",
  "o,bd,unitCube,bluDiceMat;",
  "o,gl,unitSphere,globeMat;",
  "X,rd,Rz,75;X,rd,Rx,90;X,rd,S,0.5,0.5,0.5;X,rd,T,-1,0,2;",
  "X,gd,Ry,45;X,gd,S,0.5,0.5,0.5;X,gd,T,2,0,2;",
  "X,bd,S,0.5,0.5,0.5;X,bd,Rx,90;X,bd,T,2,0,-1;",
  "X,gl,S,1.5,1.5,1.5;X,gl,Rx,90;X,gl,Ry,-150;X,gl,T,0,1.5,0;",
].join("\n");
/*
const DEF_INPUT = [
  "c,myCamera,perspective,5,5,5,0,0,0,0,1,0;",
  "l,myLight,point,0,5,0,2,2,2;",
  "p,unitCube,cube;",
  "p,unitSphere,sphere,20,20;",
  "m,redDiceMat,0.3,0,0,0.7,0,0,1,1,1,15,dice.jpg;",
  "m,grnDiceMat,0,0.3,0,0,0.7,0,1,1,1,15,dice.jpg;",
  "m,bluDiceMat,0,0,0.3,0,0,0.7,1,1,1,15,dice.jpg;",
  "m,globeMat,0.3,0.3,0.3,0.7,0.7,0.7,1,1,1,5,globe.jpg;",
  "o,rd,unitCube,redDiceMat;",
  "o,gd,unitCube,grnDiceMat;",
  "o,bd,unitCube,bluDiceMat;",
  "o,gl,unitSphere,globeMat;",
  "X,rd,Rz,75;X,rd,Rx,90;X,rd,S,0.5,0.5,0.5;X,rd,T,-1,0,2;",
  "X,gd,Ry,45;X,gd,S,0.5,0.5,0.5;X,gd,T,2,0,2;",
  "X,bd,S,0.5,0.5,0.5;X,bd,Rx,90;X,bd,T,2,0,-1;",
  "X,gl,S,1.5,1.5,1.5;X,gl,Rx,90;X,gl,Ry,-150;X,gl,T,0,1.5,0;",
].join("\n");
 */

// DO NOT CHANGE ANYTHING BELOW HERE
export { Parser, Scene, Renderer, DEF_INPUT };
