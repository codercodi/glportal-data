#version 330

uniform sampler2D sampler;

smooth in vec2 texCoord;
flat in vec4 colorPart;

out vec4 fragColor;

void main() {
	vec4 texColor = texture2D(sampler, texCoord);
	fragColor = vec4(texColor.xyz, 1.0) * colorPart;
}
