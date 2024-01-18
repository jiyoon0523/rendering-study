using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Video;
using static Unity.VisualScripting.Member;

public class VideoRenderer : MonoBehaviour
{
    [SerializeField] private VideoPlayer videoPlayer;
    [SerializeField] private Material videoMaterial;

    private UnityEvent OnVideoPrepared = new UnityEvent();

    private void Awake()
    {
        if (!this.GetComponent<MeshRenderer>())
        {
            this.AddComponent<MeshRenderer>();
        }

        var meshRenderer = this.GetComponent<MeshRenderer>();
        meshRenderer.material = videoMaterial;

        OnVideoPrepared.AddListener(() =>
        {
            videoMaterial.mainTexture = videoPlayer.texture;
            //Debug.Log($">>> videoMaterial.mainTexture: {videoMaterial.mainTexture}");

            //videoPlayer.frameReady += OnVideoFrameReady;
            videoPlayer.Play();
        });
    }
    
    private void Start()
    {
        StartCoroutine(PrepareVideo());
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.P))
        {
            videoPlayer.Pause();
        }
        else if (Input.GetKeyDown(KeyCode.S))
        {
            videoPlayer.Stop();
        }
        else if (Input.GetKeyDown(KeyCode.P))
        {
            videoPlayer.Play();
        }
    }

    private  IEnumerator PrepareVideo()
    {
        videoPlayer.Prepare();
        while (!videoPlayer.isPrepared)
        {
            yield return null;
        }
        OnVideoPrepared.Invoke();
    }

    private void OnVideoFrameReady(VideoPlayer source, long frameIdx)
    {
        Debug.Log(">>> OnVideoFrameReady");
        videoMaterial.mainTexture = source.texture;
    }
}
