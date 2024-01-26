Shader "Study/Blend Textures"
{
	Properties{
		 _MainTex("Texture", 2D) = "white"{}
	}
		SubShader{
			Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
			//Tags{"Queue" = "Overlay"}
			Blend SrcAlpha OneMinusSrcAlpha
			Pass{

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float4 vertex : SV_POSITION;
					float2 uv : TEXCOORD0;
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					return o;
				}
				
				fixed4 frag(v2f i) : SV_Target
				{
					fixed4 col = tex2D(_MainTex, float2(i.uv.x, i.uv.y * 0.5 + 0.5));
					col.a = tex2D(_MainTex, float2(i.uv.x, i.uv.y * 0.5)).r;
					return col;

					/* fixed4 c = (0 ,0, 0, 1);

					 fixed4 rgbImage = tex2D(_MainTex, float2(i.uv.x, i.uv.y * 0.5 + 0.5));
					 fixed4 alphaImage = tex2D(_MainTex, float2(i.uv.x, i.uv.y * 0.5));
					 c.rgb = rgbImage.rgb;
					 c.a = alphaImage.r;

					 return c;*/

				}

				ENDCG
			}
		}

		FallBack "Diffuse"
}

