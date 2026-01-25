#version 300 es

precision mediump float;

uniform vec2 u_resolution;
uniform float u_intensity;
uniform float u_exposure;
uniform float u_contrast;
uniform float u_saturation;
uniform float u_bloomIntensity;
uniform float u_bloomThreshold;
uniform float u_time;
uniform vec3 u_glowColor;

out vec4 fragColor;

// ACES tone mapping
vec3 acesFilm(vec3 x) {
    const float a = 2.51;
    const float b = 0.03;
    const float c = 2.43;
    const float d = 0.59;
    const float e = 0.14;
    return clamp((x * (a * x + b)) / (x * (c * x + d) + e), 0.0, 1.0);
}

// Reinhard tone mapping
vec3 reinhard(vec3 color) {
    return color / (1.0 + color);
}

// Lottes tone mapping
vec3 lottes(vec3 x) {
    const float a = 1.6;
    const float d = 0.977;
    const float hdrMax = 8.0;
    const float midIn = 0.18;
    const float midOut = 0.267;
    
    const float b = (-pow(midIn, a) + pow(hdrMax, a) * midOut) /
                     ((pow(hdrMax, a * d) - pow(midIn, a * d)) * midOut);
    const float c = (pow(hdrMax, a * d) * pow(midIn, a) - pow(hdrMax, a) * pow(midIn, a * d) * midOut) /
                     ((pow(hdrMax, a * d) - pow(midIn, a * d)) * midOut);
    
    return pow(x, vec3(a)) / (pow(x, vec3(a * d)) * b + c);
}

// Uncharted 2 tone mapping
vec3 uncharted2Tonemap(vec3 x) {
    const float A = 0.15;
    const float B = 0.50;
    const float C = 0.10;
    const float D = 0.20;
    const float E = 0.02;
    const float F = 0.30;
    return ((x * (A * x + C * B) + D * E) / (x * (A * x + B) + D * F)) - E / F;
}

vec3 uncharted2(vec3 color) {
    const float W = 11.2;
    color = uncharted2Tonemap(color * 2.0);
    vec3 whiteScale = 1.0 / uncharted2Tonemap(vec3(W));
    return color * whiteScale;
}

// Bloom effect
vec3 applyBloom(vec3 color, vec2 uv) {
    vec3 bloom = vec3(0.0);
    float weight = 0.0;
    
    // Sample surrounding pixels for bloom
    for (int i = -3; i <= 3; i++) {
        for (int j = -3; j <= 3; j++) {
            vec2 offset = vec2(float(i), float(j)) / u_resolution * 2.0;
            vec3 samp = color; // In real implementation, sample from texture
            
            // Extract bright areas
            float brightness = dot(samp, vec3(0.2126, 0.7152, 0.0722));
            if (brightness > u_bloomThreshold) {
                float dist = length(offset);
                float w = exp(-dist * dist / (2.0 * 0.5 * 0.5));
                bloom += samp * w;
                weight += w;
            }
        }
    }
    
    if (weight > 0.0) {
        bloom /= weight;
    }
    
    return color + bloom * u_bloomIntensity;
}

// Glow effect
vec3 applyGlow(vec3 color, vec2 uv) {
    vec2 center = vec2(0.5);
    float dist = distance(uv, center);
    float glow = exp(-dist * dist * 4.0) * u_intensity;
    
    // Pulsing effect
    float pulse = sin(u_time * 2.0) * 0.5 + 0.5;
    glow *= (0.8 + pulse * 0.2);
    
    return color + u_glowColor * glow;
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    
    // Base color (in real implementation, sample from texture)
    vec3 color = vec3(0.1, 0.1, 0.15); // Placeholder
    
    // Apply exposure
    color *= u_exposure;
    
    // Apply contrast
    color = (color - 0.5) * u_contrast + 0.5;
    
    // Apply saturation
    float gray = dot(color, vec3(0.2126, 0.7152, 0.0722));
    color = mix(vec3(gray), color, u_saturation);
    
    // Apply bloom
    color = applyBloom(color, uv);
    
    // Apply glow
    color = applyGlow(color, uv);
    
    // Tone mapping
    color = acesFilm(color);
    
    // Final intensity adjustment
    color *= u_intensity;
    
    fragColor = vec4(color, 1.0);
}
