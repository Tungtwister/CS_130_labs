varying vec4 position;
varying vec3 normal;
varying vec3 light_direction;

void main()
{
    vec4 ambient = vec4(1, 0, 0, 1);
    vec4 diffuse = vec4(0, 1, 0, 1);
    vec4 specular = vec4(0, 0, 1, 1);
    
    //ambient
     // Ia = Ra * La     0 <= Ra <= 1
    ambient = gl_LightSource[0].ambient * gl_LightModel.ambient * gl_FrontMaterial.ambient;
    
    //diffuse
    // Id = Rd * Ld * max(dot(n,l),0)
    vec3 n = normalize(normal);
    vec3 l = normalize(light_direction);
    diffuse += gl_FrontMaterial.diffuse * gl_LightSource[0].diffuse * max(dot(n,l),0);
    
    //specular
    // Is = Rs * Ls * max(dot(v,r),0)^alpha
    vec4 e = normalize(-position);
    vec3 r = normalize((2*dot(n,l)) * n - l);
    specular += gl_FrontMaterial.specular * gl_LightSource[0].specular * pow(max(dot(e,r),0),gl_FrontMaterial.shininess);
    
    
    gl_FragColor = ambient + diffuse + specular;
}