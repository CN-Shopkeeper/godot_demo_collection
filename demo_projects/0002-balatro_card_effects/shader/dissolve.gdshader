shader_type canvas_item;

uniform sampler2D dissolve_texture : source_color;
uniform float dissolve_value : hint_range(0,1);
// 边框尺寸
uniform float burn_size:hint_range(0.0, 1.0, 0.01);
// 燃烧效果颜色
uniform vec4 burn_color:source_color;

void fragment(){
    vec4 main_texture = texture(TEXTURE, UV);
    vec4 noise_texture = texture(dissolve_texture, UV);
	
	// 实现黄色边框溶解效果
	float burn_size_step = burn_size*step(0.001,dissolve_value)*step(dissolve_value,0.999);
	float threshold = smoothstep(noise_texture.x-burn_size_step,noise_texture.x,dissolve_value);
	float border = smoothstep(noise_texture.x,noise_texture.x+burn_size_step,dissolve_value);
	
    //main_texture.a *= floor(dissolve_value + min(1, noise_texture.x));
	// 调整颜色的透明度，根据阈值进行溶解效果的应用
	COLOR.a*=threshold;
	// 混合燃烧颜色和主纹理颜色，根据边界值应用燃烧效果
    COLOR.rgb = mix(burn_color.rgb,main_texture.rgb,border);
}