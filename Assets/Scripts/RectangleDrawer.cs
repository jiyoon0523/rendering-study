using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class RectangleDrawer : MonoBehaviour
{
    private Mesh mesh;

    private void Awake()
    {
        mesh = new Mesh();

        var meshFilter = this.GetComponent<MeshFilter>();
        if (!meshFilter) meshFilter= this.AddComponent<MeshFilter>();
        meshFilter.mesh = mesh;

        var meshRenderer = this.GetComponent<MeshRenderer>();
        if (!meshRenderer) meshRenderer= this.AddComponent<MeshRenderer>();
    }

    private void Start()
    {
        DrawRectangle();
    }

    private void DrawRectangle()
    {
        Vector3[] vertices = new Vector3[4];
        vertices[0] = new Vector3(0, 0, 0);
        vertices[1] = new Vector3(1, 0, 0);
        vertices[2] = new Vector3(1, 1, 0);
        vertices[3] = new Vector3(0, 1, 0);
        mesh.vertices = vertices;

        int[] triangles = new int[6] {
            0, 2, 1,
            0, 3, 2
        };
        mesh.triangles = triangles;

        mesh.RecalculateNormals();
    }
}
