shader_type canvas_item;

void fragment(){
    COLOR = texture(TEXTURE, UV);
    // make the pixel completely transparent
    // if it's outside the radius of the circle
    COLOR.a = 1.0 - round(distance(UV, vec2(0.5, 0.5)));
}