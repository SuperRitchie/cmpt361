import {Framebuffer} from './framebuffer.js';
import {Rasterizer} from './rasterizer.js';
// DO NOT CHANGE ANYTHING ABOVE HERE

////////////////////////////////////////////////////////////////////////////////
// TODO: Implement functions drawLine(v1, v2) and drawTriangle(v1, v2, v3) below.
////////////////////////////////////////////////////////////////////////////////

// take two vertices defining line and rasterize to framebuffer
Rasterizer.prototype.drawLine = function(v1, v2) {
  const [x1, y1, [r1, g1, b1]] = v1;
  const [x2, y2, [r2, g2, b2]] = v2;
  // TODO/HINT: use this.setPixel(x, y, color) in this function to draw line
  this.setPixel(Math.floor(x1), Math.floor(y1), [r1, g1, b1]);
  this.setPixel(Math.floor(x2), Math.floor(y2), [r2, g2, b2]);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  let dy = y2 - y1;
  let dx = x2 - x1;

  let step;
  if(Math.abs(dx) > Math.abs(dy)) {
    step = Math.abs(dx);
  }
  else {
    step = Math.abs(dy);
  }
  dx /= step;
  dy /= step;
  let x = x1, y = y1;
  let i = 1;
  let l = Math.max(Math.abs(x2 - x1), Math.abs(y2 - y1)) + 1;
  while(i <= step) {
    let colors = getColors(r1, g1, b1, r2, g2, b2, i, l);
    let r = colors[0], g = colors[1], b = colors[2];
    this.setPixel(x, y, [r, g, b]);
    x += dx;
    y += dy;
    i++;
  }
}
function getColors(r1, g1, b1, r2, g2, b2,  i, l) {
  let fraction = i/l;
  let nextR = (r2 - r1) * fraction + r1;
  let nextG = (g2 - g1) * fraction + g1;
  let nextB = (b2 - b1) * fraction + b1;
  return [nextR, nextG, nextB];
}

// take 3 vertices defining a solid triangle and rasterize to framebuffer
Rasterizer.prototype.drawTriangle = function(v1, v2, v3) {
  const [x1, y1, [r1, g1, b1]] = v1;
  const [x2, y2, [r2, g2, b2]] = v2;
  const [x3, y3, [r3, g3, b3]] = v3;
  // TODO/HINT: use this.setPixel(x, y, color) in this function to draw triangle
  this.setPixel(Math.floor(x1), Math.floor(y1), [r1, g1, b1]);
  this.setPixel(Math.floor(x2), Math.floor(y2), [r2, g2, b2]);
  this.setPixel(Math.floor(x3), Math.floor(y3), [r3, g3, b3]);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  let xMax = Math.max(x1, Math.max(x2, x3));
  let xMin = Math.min(x1, Math.min(x2, x3));
  let yMax = Math.max(y1, Math.max(y2, y3));
  let yMin = Math.min(y1, Math.min(y2, y3));

  let xs1 = x2 - x1, ys1 = y2 - y1;
  let xs2 = x3 - x1, ys2 = y3 - y1;
  for (let x = xMin; x <= xMax; x++) {
    for (let y = yMin; y <= yMax; y++) {
      let qx = x - x1, qy = y - y1;
      let s = twoD(qx, xs2, qy, ys2) / twoD(xs1, xs2, ys1, ys2);
      let t = twoD(xs1, qx, ys1, qy) / twoD(xs1, xs2, ys1, ys2);
      if ((s >= 0) && (t >= 0) && (s + t <= 1)) {
        // barycentric color interpolation
        let w1 = ((y2 - y3)*(x - x3) + (x3 - x2)*(y - y3))/((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
        let w2 = ((y3 - y1)*(x - x3) + (x1 - x3)*(y - y3))/((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
        let w3 = 1 - w1 - w2;
        let r = (w1*r1 + w2*r2 + w3*r3)/(w1 + w2 + w3);
        let g = (w1*g1 + w2*g2 + w3*g3)/(w1 + w2 + w3);
        let b = (w1*b1 + w2*b2 + w3*b3)/(w1 + w2 + w3);
        this.setPixel(x, y, [r, g, b]);
      }
    }
  }
}

function twoD(x1, x2, y1, y2) {
  return x1 * y2 - y1 * x2;
}


////////////////////////////////////////////////////////////////////////////////
// EXTRA CREDIT: change DEF_INPUT to create something interesting!
////////////////////////////////////////////////////////////////////////////////
const DEF_INPUT = [
  "v,0,0,0,0.73,1;",
"v,64,0,0,0.73,1;",
"v,0,40,0,0.73,1;",
"v,64,40,0,0.73,1;",
"v,0,64,0.78,0.46,0.2;",
"v,64,64,0.78,0.46,0.2;",
"v,0,39,0.78,0.46,0.2;",
"v,64,39,0.78,0.46,0.2;",
"v,53,0,1,1,0.7;",
"v,64,11,1,1,0.7;",
"v,64,0,1,0.82,0.7;",
"t,2,3,1;",
"t,0,2,1;",
"t,4,5,6;",
"t,5,7,6;",
"v,32,50,0.49,0.33,0.02;",
"v,32,42,0.11,0.47,0;",
"v,32,20,0.6,0,3,0.2;",
"v,25,42,0.6,0,3,0.2;",
"v,39,42,0.6,0,3,0.2;",
"l,11,12;",
"t,13,14,15;"

].join("\n");


// DO NOT CHANGE ANYTHING BELOW HERE
export { Rasterizer, Framebuffer, DEF_INPUT };