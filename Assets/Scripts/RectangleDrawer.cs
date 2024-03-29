using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class RectangleDrawer : MonoBehaviour
{
    private Mesh mesh;
    [SerializeField] private Material mat;

    private MeshFilter meshFilter;
    private MeshRenderer meshRenderer;

    [SerializeField] private Vector3[] vertices = new Vector3[4];
    [SerializeField] private Vector2[] uvs = new Vector2[4];

    private void Awake()
    {
        mesh = new Mesh();

        meshFilter = this.GetComponent<MeshFilter>();
        if (!meshFilter) meshFilter= this.AddComponent<MeshFilter>();
        meshFilter.mesh = mesh;

        meshRenderer = this.GetComponent<MeshRenderer>();
        if (!meshRenderer) meshRenderer= this.AddComponent<MeshRenderer>();
    }

    private void Start()
    {
        DrawRectangle();
        MapUVs();
        ApplyShader();
    }

    private void DrawRectangle()
    {
        Debug.Log("Draw Rectangle!");

        mesh.vertices = vertices;

        int[] triangles = new int[6] {
            0, 2, 1,
            0, 3, 2
        };
        mesh.triangles = triangles;

        mesh.RecalculateNormals();
    }
    
    private void MapUVs()
    {
        Debug.Log("Map UVs!");
        mesh.uv = uvs;
    }

    private void ApplyShader()
    {
        Debug.Log("Apply Shader!");
        meshRenderer.material = mat;
    }
}
