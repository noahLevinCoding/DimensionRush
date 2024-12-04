shader_type canvas_item;

void fragment() {

	float light_radius = 100.0;
    vec2 screen_center =  vec2(960, 400);

    float dist = distance(screen_center, FRAGCOORD.xy);

    vec4 color = vec4(0.0, 0.0, 0.0, 1.0);

    if (dist < light_radius) {
        color.a = 0.0;
    }




    COLOR = color;
}
