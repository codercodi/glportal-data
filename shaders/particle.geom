#version 130

layout(points) in;
layout(points) out;
layout(max_vertices = 40) out;

in vec3 positionPass[];
in vec3 velocityPass[];
in vec4 colorPass[];
in float lifeTimePass[];
in float sizePass[];
in int typePass[];

out vec3 positionOut;
out vec3 velocityOut;
out vec4 colorOut;
out float lifeTimeOut;
out float sizeOut;
out int typeOut;

uniform vec3 genPosition;
uniform vec3 genVelocityMin;
uniform vec3 genVelocityMax;
uniform vec4 genColor;
uniform float genSize;
uniform float genLifeTimeMin;
uniform float genLifeTimeMax;
uniform float timePassed;
uniform int genNum;
uniform vec3 randomSeed;

vec3 localSeed;
vec3 gravity;

float randZeroOne() {
    uint n = floatBitsToUint(localSeed.y * 214013.0 + localSeed.x * 2531011.0 +
                                                                     localSeed.z * 141251.0);
    n = n * (n * n * 15731u + 789221u);
    n = (n >> 9u) | 0x3F800000u;
    float res = 2.0 - uintBitsToFloat(n);
    localSeed = vec3(localSeed.x + 147158.0 * res, localSeed.y * res  + 415161.0 * res,
                                                                     localSeed.z + 324154.0 * res);
    return res;
}

void main() {
    gravity = vec3(0, -9.8, 0);
    localSeed = randomSeed;
    positionOut = positionPass[0];
    velocityOut = velocityPass[0];
    if (typePass[0] != 0) {
        positionOut += velocityOut * timePassed;
        positionOut += gravity * timePassed;
    }

    colorOut = colorPass[0];
    lifeTimeOut = lifeTimePass[0] - timePassed;
    sizeOut = sizePass[0];
    typeOut = typePass[0];

    if (typeOut == 0) {
        EmitVertex();
        EndPrimitive();
        for (int i = 0; i < genNum; i++) {
            positionOut = genPosition;
            velocityOut = genVelocityMin+vec3(genVelocityMax.x * randZeroOne(),
                            gVelocityMax.y * randZeroOne(),
                            genVelocityMax.z * randZeroOne());
            colorOut = genColor;
            lifeTimeOut = genLifeTimeMin + genLifeTimeMax * randZeroOne();
            sizeOut = genSize;
            typeOut = 1;
            EmitVertex();
            EndPrimitive();
        }
    } else if (lifeTimeOut > 0.0) {
        EmitVertex();
        EndPrimitive();
    }
}
