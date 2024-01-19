Shader "Tutorial/Texture"{
	Properties{
		_MainTex("Texture", 2D)= "white"{}
	}
		SubShader{
			Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha
			Pass{

				CGPROGRAM

	#pragma vertex vert
	#pragma fragment frag

	#include "UnityCG.cginc"

				sampler2D _MainTex;

			struct v2f {
				float4 pos: SV_POSITION;
				fixed2 uv : TEXCOORD0;  
			};

			float4 _MainTex_ST;

			v2f vert(appdata_base v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target{
				fixed4 texcol = tex2D(_MainTex, i.uv);
				if (texcol.r == 0 && texcol.g == 0 && texcol.b == 0) {
					texcol.a = 0;
			}

				return texcol;
			}

			ENDCG
		}
	}
}