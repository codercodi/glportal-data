#version 330

uniform struct matrices {
    mat4 projection;
    mat4 view;
} uniformMatrices;

uniform vec3 quad1, quad2;

layout(points) in;
layout(triangle_strip) out;
layout(max_vertices = 4) out;

in vec4 colorPass[];
in float lifeTimePass[];
in float sizePass[];
in int typePass[];

smooth out vec2 texCoord;
flat out vec4 colorPart;

void main() {
    if (typePass[0] != 0) {
        vec3 posOld = gl_in[0].gl_Position.xyz;
        float size = sizePass[0];
        mat4 viewProjection = uniformMatrices.projection * uniformMatrices.view;
        colorPart = colorPass[0];

        vec3 pos = posOld + (-quad1 - quad2) * size;
        texCoord = vec2(0.0, 0.0);
        gl_Position = viewProjection * vec4(pos, 1.0);
        EmitVertex();

        pos = posOld + (-quad1 - quad2) * size;
        texCoord = vec2(0.0, 0.0);
        gl_Position = viewProjection * vec4(pos, 1.0);
        EmitVertex();

        pos = posOld + (-quad1 - quad2) * size;
        texCoord = vec2(0.0, 0.0);
        gl_Position = viewProjection * vec4(pos, 1.0);
        EmitVertex();

        pos = posOld + (-quad1 - quad2) * size;
        texCoord = vec2(0.0, 0.0);
        gl_Position = viewProjection * vec4(pos, 1.0);
        EmitVertex();

        EndPrimitive();
    }
}
