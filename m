Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DC9D5E38A
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=d7D0+ShFaUUFk1uEPCoWaEgprFzX42XcvX+zFRfHzCs=;
  b=jIYD7WtXCh4Kuoy/Bbliz84DEAKzmOkhdx3/gPg0QW3k+jKk+JaltGNt
   r1RkOkJmTfMi2OU77piV5P3ItSOI6OVEX+VwqtgHzOvFtMIAcA9l4GaYv
   8BhL0vNe6WXeWfRZajrz5ggyDui0wBnlkWlcrS6ptRF8r6WMSoNPuYYaJ
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="193077083"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EC94E0D1D; Sun, 10 Nov 2024 02:37:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1A41AE0D1E
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:12 +0100 (CET)
IronPort-SDR: 67300e47_djrrGOdGWhMPa+5v4uoiFsywKuZAM1a8XNUe/Sh86NGFyit
 ZPXIKY/cHnm0JnmzY1GkvrLJQQPOsMajOunYBHQ==
X-IPAS-Result: =?us-ascii?q?A0FdAQCQDTBnhdlUsotaHgEBCxIMTIE8C4JEfVozBAtIW?=
 =?us-ascii?q?odLhS2IcoEWkgmKeYF+DwEDAQ0xEwQBAQMBA4UAAk8ViVcCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBgSSBJ?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEdAg1+AgEDMgENAQE3AQ9RVhmDAQGCZAOyGIEBggwBA?=
 =?us-ascii?q?QaBCNsXgWQJgUiFaodccIN9eicbgUlEgRWBO4E3doFQAYJKPYYvgkeBPYJpd?=
 =?us-ascii?q?iWICIENgW+CEIlPHh0dM4oASIEhA1khEQFVEw0KCwcFYIEXA4JWeiuBDoEXO?=
 =?us-ascii?q?oF+gSJKg1iBQkY/gkppTTcCDQI2giR9gk+FHYRvZy8DAwMDg0WCQEADCxgNS?=
 =?us-ascii?q?BEsNRQbBj5uB543AUaDLnsTAS93JS0rHCmSdy6SEKEDhCSBY4ozlSkaM4QEg?=
 =?us-ascii?q?VaLK4Y6kw6Yd5NOkCBPhGaBZzqBXDMaMIMqCUYDGQ+OIRkfhXiCXsEQNDU7A?=
 =?us-ascii?q?gcLAQEDCY5EM4FLAQE?=
IronPort-PHdr: A9a23:v4ohOxysm9dHjVrXCzJzwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xWZvaQm1wKBHd2Cra4f06yO6+GocFdDyKjCmUhBSqAEbwUCh8QSkl5oK+++Imq/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5/I
 gi6oR/NusQSjodvJKY8wQbNrndUZuha32xlKFyPkxrm+su84Jtv+DlMtvw88MJNTar1c6MkQ
 LJCCzgoL34779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRDSt9
 LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSGFcRctaSTBPDZ2gY
 IsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P727Ax3eY8HgHcxAEuH8wAvWrJotv7N6kcV
 uK6zKfHwjvMdP5axTTw5ZLUfh07vf2AQbR9etfRx0k1EAPFi02dp4v/MDOOzOsNs2mb7/BnV
 emyiWEosQRxrSKyycg2l4LEgYcVxUrf9SpjwIY1JMe4SEl7YNO/E5tfqTuaN41oTcMmWW1ov
 zw6yrIftJO9YSMFx4gpyQTFZPybb4iH/AjjVOCJLDl4h39oerOyihau/UavxePyWMi53lZUo
 idFkNTAqG0B2hzP5saHRPZx40as1DKL2gzP5O9JJUM5m6rFJ5AhwbM9kIcYv0fbHiLuhUn7g
 qubel859uWq6OnreLbrq5CGO4Nqlw3zMLwiltGjDegkKAQDXWiW9f642bH950H0QLZHg/srm
 aTHtJDaON8bprKnDA9Pz4gj6he+ACm+3dkXm3QMMUhLdwidj4fzPlHDOPD4Aum7g1SriDpk2
 v7GP7P7DpXWKXjDja3hcqpj5EJGywo808pf55RKBbEFOv7zXVXxtNPAAh84NQy73frnBc1g2
 o4QXW+DGLKVPaHRvFOS5e8iLPOAaJEItDv/M/Ql4uThjX49mV8TZ6mp2p4XZWi9Hvt8OEWWe
 3rsgtYbEWcNvgszV+/qh0OYUT5VeXmyW7gw5jYhCIKpFYvDQJuij6Sb3CinBp1WenxGCleUH
 Hv1b4mEQesDaDqOIs99lTwJTaSuS4g92h6ytQ/30KFnL+rR+i0Ar53vztl15+vJlREz7zN4F
 cqd03veB11zy2cJQSImmaN1vE15xn+d3qVixf9VD9pe47VOSAhpG4TbyrlfAsv7WgPbeZ+4Q
 VOvTtzuVTQ4VdsxwsUJcm5+Fs+kgxSF2DClVexG34eXDYA5p/qPl0P6INxwnjOfjPFJZzgOR
 8JOMTbjnatj703IAJaPlUyFlqGsfKBa3SjX9W7Fw3Dd9FpAXltWVqPIFWsaelOQtc7ws0bLV
 LauCK4gIyNCxNSEJ68Mbcfm3h1dXPm2AN3FeCqqnnuoQxOBx7eCdo3vLmAUxyzdCVIDgigQ8
 GyAOAx4AT2u8CrFFDI7M1Xpbgv39PVm7nO2Skhh1waRc0hozKa44DYZi+PaUPQOxLkJ/iQss
 TN5GBC6xd2+58OogQ1nce0cZNo85AwCzmfFr0lmOYTmKal+h1kYegAxvkX01hwxBJ8S2c4t5
 GgnygZ/M8f6mBtIai+Y0JbsO7bWNni6/RahbLTT003f19De87kG6fAxoVHu9A+zEU9q/3Ji2
 thTm3ySg/eCRA8bSpvxU1ww5jB5qqvcby174JnblDVtPaSyrj7eyocxHuJ2gh2kftpZLOaFD
 FqrSJxcXpf+brx23QLwMUFhXqga7qM/MsK4euHT3aeqOL0lhze6lSFc55g71EuQ9i16Q+qO3
 pAfwvje0BHUMlW0xFqnrM3znphJID8IGW/qgy3tH4dRZ7d1bK4IBH2oLsnxwc9xzc2IOTYQ5
 Bu4ClUK1dX8Mx+bdFX93BdXxGwUrGahlC/+yCZ72WJMzOLXzGnFxOLscwACM2hASTx5jFviF
 oOzisgTQEmiawVBeAKN3U/h3OAboa1+KzKWWkJUZ23tKHkkVKKst72EasoJ6ZUysCwRXv7uK
 VydT7f8pVMd3UaBVyNbzSsydzCwvYTRnBFgjm+ZanFpozLVdNpxyhHW+NHHDacKj3xfG3k+2
 WWRXAHjd9Cytc2ZjZLCrvyzWwfDHtVIfC/nwJnB/Cq36Gt2AAGuyvW6m9npCw8/gmfw09hnU
 zmNrQ6pO9K6kf3lYaQ3Ig8yXQCvjqgyUptzmYYxmpwKjH0Th5HOuGECjX+2KtJDn6T3cHsKQ
 zcPhd/T+gnsnkN5fRfrj8r0UGuQxsx5apy0eGQTj2g45ttDCKaO661sniZvpFe86wXLbrIu+
 1VVgetr83Mcj+wT7UAoxz6UArEIGlhwPiH2kRmMqdeko+8EAQTnOaj13014k9e7CbiEqQwJQ
 3f1dKApGipo59l+OlbBgzXjr5vpc97KYZcPpwWZxl3e2vNNJst7xZ9ozWJ3fHjwtno/x6sng
 AxyiNuk6ZOfJTwl/brlUEMCcGeoIZpIq3e00f4Wn97Kjdn0T9M4RWVNDMeuF6v3dVBa/fX/a
 1TXTGB69i/dR+qZQlLX6V86/SuTTtb3bzfIfz9EkJ1jXEXPfRAAxl9JGmxrxdhoT2XIjITga
 BkrvG5Jugyh8UsUmL42b0CtXz+H9lXvNGt8SYDBfkAItl0QvhyFaZ7Ctu8qTX0IpsXz/kvTd
 gn5L0xJFT9bABLcWwK6Zen2t4Wer7HKDbfmd6mcJuvS4e1GCaXSm8rzgNI9r27eapiDZytvB
 KVjiBgEAywceYyRjTwLT2Z/ezvlScmdqV/8/yR2qpv66/H3QEf04pPJDbJOMNJp8hTwgKGZN
 ufWijwrYTBfnogBw3PF0t19lBYblj1uej+xEL8BqT+FTaTenbVSBgIabCU7PdVB7qY11A1Ac
 cDBjda92rl9h/8zQ1BLMD6p0tmuftAPKnqhOUnvCEiUcq+BOCfAzof0bLm6RLkWi/9b9lWxt
 TudD07/L2GDmj3uBHXNealHiCCWOgAbuZnoK008TzG8HJS2NlvhaYAk6F9+iac5jX7LK2MGZ
 D11ckcW66aV8TsdmfJnXWpI8ntiK+CA3Sef9ejRbJgM4p4JSmx5kfxX5HMixv5b9iZBEbZwk
 TDbrt90pECOkeSVzDdjFh1UpXwY4eDD9VUnIqjf+pRaDDzc+wkR6GyLFxkQj9drFZv0vL1Kw
 dWJl6/pLjpGtdXO8oFPYqqcYNLCO30nPx3zHTfSBwZQVj+nO1bUgElFme2T/HmYxnDfgpvhg
 pwDTvlcTlNnTpvy62xpEsNEO5BqRDgp172WlsgF4Ty5thaDHK2yUbjEW+iUDPGpLyyW3+AsW
 g==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:MO51equt+wKdn9AmdxUPaL/t7skDedV00zEX/kB9WHVpmwKj+f
 xG+85rsyMc7Qx9ZJhOo7C90cW7LU80sKQFhLX5Xo3SOzUO2lHYT72KhLGKq1aLJ8S9zJ846U
 4KSclD4bPLYmSS9fyKgjWFLw==
X-Talos-CUID: 9a23:0nN2zWNaxG7c0+5Df3JB/k9PNsocfT7n3XiMOmiFL0I2YejA
X-Talos-MUID: 9a23:v5gaxwkozPf2t8DmnuF2dnpkc/1n3IWJA3oQiMoDtPanFjFiZBOC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200591"
X-MGA-submission: =?us-ascii?q?MDHoPfwfN6/SIxu/i2tk2PZvR46w+xqDwKZ/we?=
 =?us-ascii?q?VD97QbEAZsk2r6McdhI4xWyBqwqgfzlUKcn+sTOpwVrWU4ZVUsufnGmn?=
 =?us-ascii?q?+o3IG/5tR9AP7gnKeS1r/LMcYwnD5PKFfO4yHtko1p7FuaGnr1ebE3cD?=
 =?us-ascii?q?dKk6k6zOa9v8Z9BRcVHNZwNA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:11 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9E4715C576A;
	Sun, 10 Nov 2024 01:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB330C4CED4;
	Sun, 10 Nov 2024 01:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202630;
	bh=Wf268ApS1D6QJ4TyEFsF5qod3tLLDRZrfLTApp+4NVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGy/5q8R96N0gt2yyUnabXRSlHEhCzw6rpmrevpY7csp+2OFpPbxjAV7WNgsIO91K
	 kvgyshHY+E8rhnFv79EaxAn//O5gAsVUJWeEVTo7DfMTV/kG6iAyK6KYZXorXtANJe
	 VFhxXhp6o0MVTo+ZcURcN3ZL6b8GOmVEf0ZkhBNEQqhRlWAGFaHP/gD85i0O1OdC2e
	 BEYemZX0IRp3wvPoJbdoCZ3po8rDbkUe+h+1NakUH3jU99TEGpKHtLuvjdF95SduSB
	 sRIQ3zi+pBO4Ev9264K/LZ8kfA/k94+KPWup79dS4/N7ONDVRA8U6AMwsf+DGTJyXc
	 tIz0w5dT6Q9RA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Date: Sun, 10 Nov 2024 10:34:35 +0900
Message-ID: <20241110013649.34903-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 07/11] kbuild: support building external modules
 in a separate build directory
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1982
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-8-masahiroy%40kernel.org>

There has been a long-standing request to support building external
modules in a separate build directory.

This commit introduces a new environment variable, KBUILD_EXTMOD_OUTPUT,
and its shorthand Make variable, MO.

A simple usage:

 $ make -C <kernel-dir> M=<module-src-dir> MO=<module-build-dir>

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v2:
  - Add -I $(src) -I $(obj) for external modules as well
  - Fix a typo 'Speficies' to 'Specifies'.

 Documentation/kbuild/kbuild.rst  |  8 +++++++-
 Documentation/kbuild/modules.rst |  8 +++++++-
 Makefile                         | 22 +++++++++++++++++++---
 scripts/Makefile.host            |  8 +++-----
 scripts/Makefile.lib             |  2 --
 5 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 1796b3eba37b..17c9f920f03d 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -137,12 +137,18 @@ Specify the output directory when building the kernel.
 This variable can also be used to point to the kernel output directory when
 building external modules against a pre-built kernel in a separate build
 directory. Please note that this does NOT specify the output directory for the
-external modules themselves.
+external modules themselves. (Use KBUILD_EXTMOD_OUTPUT for that purpose.)
 
 The output directory can also be specified using "O=...".
 
 Setting "O=..." takes precedence over KBUILD_OUTPUT.
 
+KBUILD_EXTMOD_OUTPUT
+--------------------
+Specify the output directory for external modules.
+
+Setting "MO=..." takes precedence over KBUILD_EXTMOD_OUTPUT.
+
 KBUILD_EXTRA_WARN
 -----------------
 Specify the extra build checks. The same value can be assigned by passing
diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index cd5a54d91e6d..a01f3754c7fc 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -66,7 +66,10 @@ Options
 	of the kernel output directory if the kernel was built in a separate
 	build directory.)
 
-	make -C $KDIR M=$PWD
+	You can optionally pass MO= option if you want to build the modules in
+	a separate directory.
+
+	make -C $KDIR M=$PWD [MO=$BUILD_DIR]
 
 	-C $KDIR
 		The directory that contains the kernel and relevant build
@@ -80,6 +83,9 @@ Options
 		directory where the external module (kbuild file) is
 		located.
 
+	MO=$BUILD_DIR
+		Specifies a separate output directory for the external module.
+
 Targets
 -------
 
diff --git a/Makefile b/Makefile
index c7eeb10455b6..38ce19747728 100644
--- a/Makefile
+++ b/Makefile
@@ -134,6 +134,10 @@ ifeq ("$(origin M)", "command line")
   KBUILD_EXTMOD := $(M)
 endif
 
+ifeq ("$(origin MO)", "command line")
+  KBUILD_EXTMOD_OUTPUT := $(MO)
+endif
+
 $(if $(word 2, $(KBUILD_EXTMOD)), \
 	$(error building multiple external modules is not supported))
 
@@ -187,7 +191,7 @@ ifdef KBUILD_EXTMOD
     else
         objtree := $(CURDIR)
     endif
-    output := $(KBUILD_EXTMOD)
+    output := $(or $(KBUILD_EXTMOD_OUTPUT),$(KBUILD_EXTMOD))
     # KBUILD_EXTMOD might be a relative path. Remember its absolute path before
     # Make changes the working directory.
     srcroot := $(realpath $(KBUILD_EXTMOD))
@@ -555,7 +559,7 @@ USERINCLUDE    := \
 LINUXINCLUDE    := \
 		-I$(srctree)/arch/$(SRCARCH)/include \
 		-I$(objtree)/arch/$(SRCARCH)/include/generated \
-		$(if $(building_out_of_srctree),-I$(srctree)/include) \
+		-I$(srctree)/include \
 		-I$(objtree)/include \
 		$(USERINCLUDE)
 
@@ -645,6 +649,7 @@ quiet_cmd_makefile = GEN     Makefile
 	} > Makefile
 
 outputmakefile:
+ifeq ($(KBUILD_EXTMOD),)
 	@if [ -f $(srctree)/.config -o \
 		 -d $(srctree)/include/config -o \
 		 -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
@@ -654,7 +659,16 @@ outputmakefile:
 		echo >&2 "***"; \
 		false; \
 	fi
-	$(Q)ln -fsn $(srctree) source
+else
+	@if [ -f $(srcroot)/modules.order ]; then \
+		echo >&2 "***"; \
+		echo >&2 "*** The external module source tree is not clean."; \
+		echo >&2 "*** Please run 'make -C $(abs_srctree) M=$(realpath $(srcroot)) clean'"; \
+		echo >&2 "***"; \
+		false; \
+	fi
+endif
+	$(Q)ln -fsn $(srcroot) source
 	$(call cmd,makefile)
 	$(Q)test -e .gitignore || \
 	{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
@@ -1940,6 +1954,8 @@ KBUILD_MODULES := 1
 
 endif
 
+prepare: outputmakefile
+
 # Preset locale variables to speed up the build process. Limit locale
 # tweaks to this spot to avoid wrong language settings when running
 # make menuconfig etc.
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index e01c13a588dd..c1dedf646a39 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -96,12 +96,10 @@ hostrust_flags = --out-dir $(dir $@) --emit=dep-info=$(depfile) \
                  $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
                  $(HOSTRUSTFLAGS_$(target-stem))
 
-# $(objtree)/$(obj) for including generated headers from checkin source files
-ifeq ($(KBUILD_EXTMOD),)
+# $(obj) for including generated headers from checkin source files
 ifdef building_out_of_srctree
-hostc_flags   += -I $(objtree)/$(obj)
-hostcxx_flags += -I $(objtree)/$(obj)
-endif
+hostc_flags   += -I $(obj)
+hostcxx_flags += -I $(obj)
 endif
 
 #####
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index e7859ad90224..5660dfc9ed36 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -213,13 +213,11 @@ endif
 
 # $(src) for including checkin headers from generated source files
 # $(obj) for including generated headers from checkin source files
-ifeq ($(KBUILD_EXTMOD),)
 ifdef building_out_of_srctree
 _c_flags   += $(addprefix -I, $(src) $(obj))
 _a_flags   += $(addprefix -I, $(src) $(obj))
 _cpp_flags += $(addprefix -I, $(src) $(obj))
 endif
-endif
 
 # If $(is-kernel-object) is 'y', this object will be linked to vmlinux or modules
 is-kernel-object = $(or $(part-of-builtin),$(part-of-module))
-- 
2.43.0

