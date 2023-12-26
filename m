Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBCCC46CD3
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=+rs5RmvR8yoLEeGj5f51IfJlLG5pToU2UWDnTVTgvY4=;
  b=YWKSLOPDW2bvikx1eboIFubGiQchsIY+1+WWttH4f+z3i5KpzsifEC3j
   M0XBYEpLVS476hV/uMcK4RtJ+g060IbUexzciEtBc3hg/CaFj+5TaT9yh
   FIOtYqM/YH/jn0tZBhIERei2WK38BWCEEoT1G/gtjihJqpXwdVkTU2UXw
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144068666"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 18:34:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AA7EDE0CCA; Tue, 26 Dec 2023 18:34:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2BAA7E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 18:34:18 +0100 (CET)
IronPort-SDR: 658b0e9a_BS3CXKCk5DScSk7qNP+tkH933Y8U3rVEs+R17OjRKobfL7F
 ZTOVhAX/u+/i1H5kVQoq4rG3GFeVLQgItda8t7g==
X-IPAS-Result: =?us-ascii?q?A0FkAAACDYtl/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4B3hTMgQLSIRTj0GBdS2EPoc1jDeEBIFWFIEsPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ3AYRHhzgCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR2sEGQEBE?=
 =?us-ascii?q?SYBLgEFAiYCXgESAgEBgnyCKwEDMQeubX8zgQGCCgEBBq9YHywiVoFgCYEaL?=
 =?us-ascii?q?gGIGgGFZ4NBgSEPgVVEgRUng0GEKoN0gmiIXzwHMoIdgnNdgQ+QSH0EAUFwG?=
 =?us-ascii?q?wMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIMvCoEBPw8OEYI+IgI9NhlIglgVD?=
 =?us-ascii?q?DUERnUQKgQUF4EPbhsSHjcREBcNAwh0HQIRIzwDBQMEMwoSDQshBVYDQgZJC?=
 =?us-ascii?q?wMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADaR8yCTwPD?=
 =?us-ascii?q?BoCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLAY4AhIMBgYJXSYHDwkEJQMIB?=
 =?us-ascii?q?AMrKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGPgKmRQd7E3KBCzNGM?=
 =?us-ascii?q?JJCCQEHkwyecjQHgjSBYIFhDJ8rBhMvlyYOBpJTAS6YHyCoRoFqDCqBWTMaJ?=
 =?us-ascii?q?IM2TwMZD44gDBaECY8JAT1ANTsCBwEKAQEDCYVGAQGDKC0FgUYBAQ?=
IronPort-PHdr: A9a23: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
 VNpPnHISuAI54Y=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tikEoa0gd+b2EgD59zu5cAqjBGokLtp133Aq2lEZdPWaSL37qy
 ncppQmPHjP+VAssRAb6Le90cy7Kk80mqQb3WB8B8bGYOCEggWVxeNZgbcKqgeIc0DDH4VmpM
 NdmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utEuFATsKV0l6hT0Jczpz/3cGPDWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:hApD7mMZDmvvAO5DZRZ8+U4FCPEZKHTenXiTO1OEKlZyV+jA
X-Talos-MUID: 9a23:x9QdqgRx/9qmEan0RXTQ2x1gbZ1Fu5ihNxhKi64ohuSiMhFZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144068661"
X-MGA-submission: =?us-ascii?q?MDHvdUjRAV5BCFXincf/rPlQOJobgC8YlXGCBz?=
 =?us-ascii?q?U9NXPSNcAFc3EyXuFiz5o/5JEfMozMrPP8QV4ME0L/qme90IfXErqTbo?=
 =?us-ascii?q?clt0DexkqxvzDRD3mFm38zoFsvZ5rupIt96llSPjZBFAp+FxJOaxoJ0+?=
 =?us-ascii?q?+dF1ajxTDlMEd65vgcDU67fw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 18:34:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703612004; x=1704216804; i=markus.elfring@web.de;
	bh=AuhcszHwHjGP9Acn89BVl5MLLXrMpR0aVvDveRatoik=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=bG5SFJ+bYfMdlpGE1cElBR5x1ijpvWLrkp6loXWkOoDmOoBXR0L53mMfHRgyu1v2
	 RrVDJqRD9hd6SX+zDKcIjeq77aF3DPWOogjNATijcmLPRbqn8bMO8tqucz3Ndz6JK
	 3IYE/RQgrbtSIijS9YSHaveF+38NNWHbb55wi6bgiOujYezqxmIITs3Vqh468A7mn
	 nCfwUKWtqf4aGEJ469/wks35vDHZ1oZ9TsfMmEcRlEAR8wj1VOGSIQpRP2vfwOANe
	 FMjGchaP6nVU2vm1F/G/kQCr3CN/Vstyf0BaFKXJVbDeP2K+cxsy5FRhzYVhmZLC8
	 2bkjcKS04SntJZ0o1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElV3-1rSOi72PWd-00GAan; Tue, 26
 Dec 2023 18:33:24 +0100
Message-ID: <189166d6-b76a-412a-bfcf-8ba14578a317@web.de>
Date: Tue, 26 Dec 2023 18:33:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cqYAChBIlAwDCrpDesRT8Rcxu7TED955U2F15R9o1Lvz0JJr2FN
 uTKhH5RtR8P3nvpkDaA6FP3Z3AbzDluXJ9BYxHm7kZw+Wsl6SUnXMBcxkzReBqCZJWFYIZD
 +qKKAvP4dAuXEx9vhylypm1hlJdFyORz9GujswISk/AkMx8D9gvS82GVer/xy+zvDsQstS6
 U9M8IklMQJXMOEO59DWqA==
UI-OutboundReport: notjunk:1;M01:P0:riS9T522lis=;57fc1AQoeN3UHWwK3JukaIDA71E
 oQuOiPMRZaDTXd0YVGVRZE+jXL0z8W6Bujhd0Q9IZ5uRgiedPwsqmvoKDuW37PaceJ6sRPCpG
 D9/G21S0YOVs/dUqtHHm1uaJKuVXYwqaiDSFeiu9dkywsjC2ZLP1iSSb00Gxfj35YRtH8R1k5
 HEY3Q5yST+1Y1SkCN92+dxUsOe8FkGKOUyUBAwN4bgfanTwcVZNjHwGy4IFAP1MZeHJQl/iv7
 OXuLrgiqUBG0OW+goOGFqXiZtFnQgpbXEIBFdoMJ93uTUetUCOQJLY9AqrUrqZjQeulaAzK8U
 4DKjLvIt908q0FbLhPffo4sOGBIMOmqvw9/ZM4W1pi6KrlqCCn69asLMstQcLwRoqcl3VcNyE
 wUIzIRa5SDAJ6/adhbIQJUu0vJLB8cYfmQFwz2XVOS8feiujbhaxruhTDUdWrQwAsibSunSWr
 EDOFHdlqumaLo0HoLHhH1fIrrmPw3gdn3q66xrqPxGMO7iT6azfn3+RgKVwOmk9Kd/2dXP5ml
 2/a3S9zs4LF7GDVYN7U9RDmY5GsIyCzxdBjaWwc2Fvs2hCmrHT5GDVNiU1eAIUZ3uEnrSR1hT
 QBf7vNXjqE7lO2qZEg8hANyH3xR2wJpL4RuZ+w9rDLT+96EIpWdsghb99ljNFB4uSOdVYqsAB
 PQyCLQcYNadkiurQTQ6rL5QnuKTBEznJ5Qh8+vjvSaiFvMtLksunegF9uF1/8f5T2fRmAOsKK
 QegbLA3QlO62jPozlTViu3vNSxP5mlJQDFqjqQld6cN8kHgXgifllQsotBPf6JGllZ7NToWOi
 L+gghKSFDbhLQGhWd64phzNSbrkSJYhTBaFvPZV9ywHCsjQPlVtIQyyM4hB5AjZpjwApcFhpp
 o/4ct1Fi/qDO81XIE9h8bIYrfK5uvPCE5AlHoZmF9ebd/Oc+Pr6pqwZjZ+dveKVLpv5YPZdjd
 qMj77gRzkgSUok4y7iyPo6/3pQ0=
Subject: [cocci] [PATCH] drm/vc4: Improve exception handling in
 vc4_validate_shader()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1401
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/189166d6-b76a-412a-bfcf-8ba14578a317%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 18:22:54 +0100

Memory releases were triggered during error handling only over
the label =E2=80=9Cfail=E2=80=9D.

1. Return directly after a call of the function =E2=80=9Ckcalloc=E2=80=9D =
failed
   at the beginning.

2. Reduce the data processing at the end to a required kfree() call order
   also by adjusting jump targets.

3. Delete an initialisation for the variable =E2=80=9Cvalidated_shader=E2=
=80=9D
   which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/vc4/vc4_validate_shaders.c | 42 +++++++++++-----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/=
vc4/vc4_validate_shaders.c
index 9745f8810eca..d76787bb7d51 100644
=2D-- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -783,7 +783,7 @@ vc4_validate_shader(struct drm_gem_dma_object *shader_=
obj)
 	int shader_end_ip =3D 0;
 	uint32_t last_thread_switch_ip =3D -3;
 	uint32_t ip;
-	struct vc4_validated_shader_info *validated_shader =3D NULL;
+	struct vc4_validated_shader_info *validated_shader;
 	struct vc4_shader_validation_state validation_state;

 	if (WARN_ON_ONCE(vc4->is_vc5))
@@ -799,14 +799,14 @@ vc4_validate_shader(struct drm_gem_dma_object *shade=
r_obj)
 		kcalloc(BITS_TO_LONGS(validation_state.max_ip),
 			sizeof(unsigned long), GFP_KERNEL);
 	if (!validation_state.branch_targets)
-		goto fail;
+		return NULL;

 	validated_shader =3D kcalloc(1, sizeof(*validated_shader), GFP_KERNEL);
 	if (!validated_shader)
-		goto fail;
+		goto free_targets;

 	if (!vc4_validate_branches(&validation_state))
-		goto fail;
+		goto free_shader;

 	for (ip =3D 0; ip < validation_state.max_ip; ip++) {
 		uint64_t inst =3D validation_state.shader[ip];
@@ -815,7 +815,7 @@ vc4_validate_shader(struct drm_gem_dma_object *shader_=
obj)
 		validation_state.ip =3D ip;

 		if (!vc4_handle_branch_target(&validation_state))
-			goto fail;
+			goto free_offsets;

 		if (ip =3D=3D last_thread_switch_ip + 3) {
 			/* Reset r0-r3 live clamp data */
@@ -842,12 +842,12 @@ vc4_validate_shader(struct drm_gem_dma_object *shade=
r_obj)
 			if (!check_instruction_writes(validated_shader,
 						      &validation_state)) {
 				DRM_DEBUG("Bad write at ip %d\n", ip);
-				goto fail;
+				goto free_offsets;
 			}

 			if (!check_instruction_reads(validated_shader,
 						     &validation_state))
-				goto fail;
+				goto free_offsets;

 			if (sig =3D=3D QPU_SIG_PROG_END) {
 				found_shader_end =3D true;
@@ -861,7 +861,7 @@ vc4_validate_shader(struct drm_gem_dma_object *shader_=
obj)
 				if (ip < last_thread_switch_ip + 3) {
 					DRM_DEBUG("Thread switch too soon after "
 						  "last switch at ip %d\n", ip);
-					goto fail;
+					goto free_offsets;
 				}
 				last_thread_switch_ip =3D ip;
 			}
@@ -872,26 +872,26 @@ vc4_validate_shader(struct drm_gem_dma_object *shade=
r_obj)
 			if (!check_instruction_writes(validated_shader,
 						      &validation_state)) {
 				DRM_DEBUG("Bad LOAD_IMM write at ip %d\n", ip);
-				goto fail;
+				goto free_offsets;
 			}
 			break;

 		case QPU_SIG_BRANCH:
 			if (!check_branch(inst, validated_shader,
 					  &validation_state, ip))
-				goto fail;
+				goto free_offsets;

 			if (ip < last_thread_switch_ip + 3) {
 				DRM_DEBUG("Branch in thread switch at ip %d",
 					  ip);
-				goto fail;
+				goto free_offsets;
 			}

 			break;
 		default:
 			DRM_DEBUG("Unsupported QPU signal %d at "
 				  "instruction %d\n", sig, ip);
-			goto fail;
+			goto free_offsets;
 		}

 		/* There are two delay slots after program end is signaled
@@ -905,7 +905,7 @@ vc4_validate_shader(struct drm_gem_dma_object *shader_=
obj)
 		DRM_DEBUG("shader failed to terminate before "
 			  "shader BO end at %zd\n",
 			  shader_obj->base.size);
-		goto fail;
+		goto free_offsets;
 	}

 	/* Might corrupt other thread */
@@ -913,7 +913,7 @@ vc4_validate_shader(struct drm_gem_dma_object *shader_=
obj)
 	    validation_state.all_registers_used) {
 		DRM_DEBUG("Shader uses threading, but uses the upper "
 			  "half of the registers, too\n");
-		goto fail;
+		goto free_offsets;
 	}

 	/* If we did a backwards branch and we haven't emitted a uniforms
@@ -927,7 +927,7 @@ vc4_validate_shader(struct drm_gem_dma_object *shader_=
obj)
 	 */
 	if (validation_state.needs_uniform_address_for_loop) {
 		if (!require_uniform_address_uniform(validated_shader))
-			goto fail;
+			goto free_offsets;
 		validated_shader->uniforms_size +=3D 4;
 	}

@@ -943,12 +943,12 @@ vc4_validate_shader(struct drm_gem_dma_object *shade=
r_obj)

 	return validated_shader;

-fail:
+free_offsets:
+	kfree(validated_shader->uniform_addr_offsets);
+	kfree(validated_shader->texture_samples);
+free_shader:
+	kfree(validated_shader);
+free_targets:
 	kfree(validation_state.branch_targets);
-	if (validated_shader) {
-		kfree(validated_shader->uniform_addr_offsets);
-		kfree(validated_shader->texture_samples);
-		kfree(validated_shader);
-	}
 	return NULL;
 }
=2D-
2.43.0

