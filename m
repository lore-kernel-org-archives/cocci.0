Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4253CC282EC
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 21:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=QTOGKi9JhdQhGKPwufxPKVtd5TsRsO2/tiVnVPSdJzY=;
  b=VNS0+YNewni3KQrxTEWdoyO0td1F2vP6yEpG60IcAPn3tVdve43wgdj2
   di74xArUJTlDikJvvOcYVbBlq3KutA6kXjS0pIVTMLr+zNdNlrcDu/drr
   c756IPm8RCzSwioOVN1B+yW2qwCOz90U3RBl97KcvD/qRkSR1JOD8pY5r
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="213354592"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2025 22:36:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ADBF1E0261; Mon, 17 Mar 2025 22:36:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 740B2E0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 22:36:25 +0100 (CET)
IronPort-SDR: 67d895d9_8kzmoN39BYrX3t57vHyXW/pJHMyCj+k7XNwC4LybaQx6ubQ
 e4kPSPjQSWZeyZXZdNHyjTjEkGritLt+AGTOrIg==
X-IPAS-Result: =?us-ascii?q?A0F8AgAbldhnjaOSqVFagQmBUwKCQn1ZNAcISGGHRI4ik?=
 =?us-ascii?q?x6KeYFWKA8BAwENNQ8EAQEDAQOFAIshAh8GAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFDgkyhUwvDUkBEAGCADtxgSUBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINGQ4QZw0LAQcGAQE4UH+DAgGCZAeuD4EBM4EBggwBA?=
 =?us-ascii?q?QaBCIFg2TiBZQmBSIVtgmMBhHxvAYR3JxuCDYEUAYE7g32DCIYvgjODPYFqg?=
 =?us-ascii?q?WyHZYJqHC2CJYJ+inuMc0iBBRwDWSwBVRMNCgsHBYFsAzUMCy4VgUVDN4JDa?=
 =?us-ascii?q?Uk6Ag0CNYIbfIIohE6EPIRBhVCCEYIFiSyEZC1QgU0dQAMLGA1IESw3FBsGP?=
 =?us-ascii?q?m4HohYBOoQQMwEWQywJAS+BF2kBLAw6knGxbYE+gj+BZoFjijWVMBozgUuED?=
 =?us-ascii?q?5FsDpMDmH6kS4RogWc6gVwzGggcFIMiCUYDGQ+NeAExEAmBSYJCgiOBMRiCM?=
 =?us-ascii?q?bQHRTI8AgcLAQEDCYkAhxyBSwEB?=
IronPort-PHdr: A9a23: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
 Ns7NVCGUEYiirecRU1hCA==
IronPort-Data: A9a23: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
 J83q6awD7iq50Eu
IronPort-HdrOrdr: A9a23:gTjS1a+NGGLBvg/Ipuduk+ABI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc7wxhIE3I+OrwQ5VoJEmym6KdjrNhWYtKMDOW21dAT7sSlLcKoQeQfBEWn9Q1vc
 ddmsNFebjN5DZB/KTHCXGDYrAd6ejCy5OHwc/j8lYFd2BXQpAl1DRWTiy/OndNAClqbKBUKK
 ah
X-Talos-CUID: =?us-ascii?q?9a23=3AZiKW1GvYk+Hwil/6oiFP6ylQ6It5fXvz91mOPnW?=
 =?us-ascii?q?aImxXbbSTRniayIZ7xp8=3D?=
X-Talos-MUID: 9a23:jLdyagWhmLT3fdvq/Bjejm8/F+FB37anEV0kkr4q6s+uOTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="213354587"
X-MGA-submission: =?us-ascii?q?MDF5ZZinOtoSq42PLgTyPKb0f0CZw6eomPTmu8?=
 =?us-ascii?q?F5ZPMBHq1q+ZqXu93zwgL3fD6CjBCbGPpVdviH9L1RsJN4ephXP886GY?=
 =?us-ascii?q?+vwq9l848k84xcDGpGPLf+/E0lbFc6/Oo1WIF2bn/IbQ/Qexwc2aZwKT?=
 =?us-ascii?q?VFUlEbI7sl1+dRwoerRZF9qw=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 22:36:24 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742247383; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QiFsz5t87TpcycPyPx5jT7YAEQrbUGBiwddLK3QXT75wwvp/hCKDDMse7K6uSR3SWz
    tvDt+esbNsrZN3z5A0HqqNDXYAeV3OiXjESOS6jEfBWXHw51EiDvoCZm+S1/xeuplpfq
    Mvs30fRMlNL+7nwoZKb6R8c4FU345Hc4MSHO05hESFgj9jYceCFHxEf/bFRj35O+OVrU
    50GXaIEYwjLTLj5wZZJgmkY4yOODRXdmMPc6hiGJ0cYCI9qnz1CDBLYG+nLcP7FWigSX
    7+oBXjNou9qVzvDEteyY2hBG5W2W4FBZ0ZHVeGTSkC0znrBb27LD9ugi0GB2kGcCDbG2
    oG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742247383;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=QTOGKi9JhdQhGKPwufxPKVtd5TsRsO2/tiVnVPSdJzY=;
    b=hz6QFnR7dw5eP+J0LekH81Dv46Dmw1a5wZYCkclwjBXUuuLfLYjrdh+tJiFAb+zkk4
    UbDmPXZ86pnOOP8/fY4e8ZIP3wCnKiFhvkf3YE/KibzLmHxiYiUR5oNDAajpwSb9vZrs
    4cOGo8ZpXrLscbnnM8YuCJqF1q+B+1hUud4rds8tjlrGB5kZPfn5NFd7Nv8dNwFbLNyf
    8pVGnw+bEdWTJuqalbevojGBXxC3wPQ6XCcIAV0SOYeB1TdAgNs8rHCC890vN7bYOWGK
    3mf7d6nug//6mEBm9UEHn2txpczAuBmas8I/FWc3AUh0OPMD9+yEPZ2kytUEJSe+bJUc
    V5nA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742247383;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=QTOGKi9JhdQhGKPwufxPKVtd5TsRsO2/tiVnVPSdJzY=;
    b=HLM4GgLeGvHhZxjuTNapeiAJRENI0JFU1nJRkssDPfv6w8DW56iOpkWnr9SXFjlb/+
    ZkO0Dh5cgFEeascvmiYcjvgC1tIGpEgZRigmVMS/N03efYIy3T+d28H68dRwuW0KjNSe
    KNaLhXlU51a+24ipRB0Jt3dTYtnOjoNlVRnynHKFJpuHf3k0uN+XrMxtIkvuD7lxcrHa
    j5EcrA1gQ/798OqgsarMfg8Rx4HAkddgvRoMj1byT2+ZpzIfHUST4/evSmpdMxM/23ji
    u1zx0rhxE9LhY9HZqA46mu3RGPibH6Rz7QdyEDNtwcMcdVS2Z1jCjWDHLuaFazm72Vi0
    P7ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742247383;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=QTOGKi9JhdQhGKPwufxPKVtd5TsRsO2/tiVnVPSdJzY=;
    b=oAfnQszU5iSgSE6ZjqcNgunhrAl0aArnZx8mveBvtIEmbrLBBb1CTPbxZAbtS1XEbB
    Fe/MDJgn8RYxTTz0wnCA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSVYjagMyZmkab3cQQk8ITYm/c/zHbXf6Nw2MS9"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12HLaMy7X
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Mon, 17 Mar 2025 22:36:22 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Date: Mon, 17 Mar 2025 22:35:44 +0100
Message-ID: <20250317213619.14674-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Subject: [cocci] [PATCH v2] replace pcre with pcre2
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2592
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250317213619.14674-1-olaf%40aepfle.de>

Since pcre is unmaintained, the usage of ocaml-pcre will be replaced
with ocaml-pcre2. While other regular expession libraries for OCaml
exists, they are not as feature complete as pcre2 is.

This is the minimal change to use ocaml-pcre2. To reduce the size of
this patch, a separeate commit will be required to import
pcre2-ocaml.git into bundles/pcre2.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 Makefile                                      | 15 +++++++-------
 Makefile.config.in                            | 18 ++++++++---------
 Makefile.libs                                 | 18 ++++++++---------
 bundles/{pcre => pcre2}/.gitignore            |  0
 bundles/{pcre => pcre2}/Makefile              |  0
 bundles/{pcre => pcre2}/bytes_compat.ml       |  0
 bundles/{pcre => pcre2}/pcre-ocaml/.gitignore |  0
 bundles/{pcre => pcre2}/pcre-ocaml/CHANGES.md |  0
 bundles/{pcre => pcre2}/pcre-ocaml/LICENSE.md |  0
 bundles/{pcre => pcre2}/pcre-ocaml/Makefile   |  0
 bundles/{pcre => pcre2}/pcre-ocaml/README.md  |  0
 bundles/{pcre => pcre2}/pcre-ocaml/dune       |  0
 .../{pcre => pcre2}/pcre-ocaml/dune-project   |  0
 .../pcre-ocaml/examples/Makefile              |  0
 .../pcre-ocaml/examples/README.md             |  0
 .../pcre-ocaml/examples/cloc.ml               |  0
 .../pcre-ocaml/examples/count_hash.ml         |  0
 .../{pcre => pcre2}/pcre-ocaml/examples/dune  |  0
 .../pcre-ocaml/examples/pcregrep.ml           |  0
 .../pcre-ocaml/examples/subst.ml              |  0
 bundles/{pcre => pcre2}/pcre-ocaml/pcre.opam  |  0
 .../pcre-ocaml/pre-v7.3.0-CHANGES.txt         |  0
 .../{pcre => pcre2}/pcre-ocaml/src/.gitignore |  0
 .../{pcre => pcre2}/pcre-ocaml/src/Makefile   |  0
 .../pcre-ocaml/src/config/Makefile            |  0
 .../pcre-ocaml/src/config/discover.ml         |  0
 .../pcre-ocaml/src/config/dune                |  0
 bundles/{pcre => pcre2}/pcre-ocaml/src/dune   |  0
 .../{pcre => pcre2}/pcre-ocaml/src/pcre.ml.in |  0
 .../{pcre => pcre2}/pcre-ocaml/src/pcre.mli   |  0
 .../pcre-ocaml/src/pcre_stubs.c.in            |  0
 coccinelle.opam                               |  2 +-
 configure.ac                                  | 20 +++++++++----------
 globals/regexp_pcre.ml                        | 10 +++++-----
 install.txt                                   | 16 +++++++--------
 setup/fake-subst.sh                           |  6 +++---
 36 files changed, 52 insertions(+), 53 deletions(-)
 rename bundles/{pcre => pcre2}/.gitignore (100%)
 rename bundles/{pcre => pcre2}/Makefile (100%)
 rename bundles/{pcre => pcre2}/bytes_compat.ml (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/.gitignore (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/CHANGES.md (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/LICENSE.md (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/Makefile (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/README.md (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/dune (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/dune-project (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/examples/Makefile (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/examples/README.md (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/examples/cloc.ml (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/examples/count_hash.ml (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/examples/dune (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/examples/pcregrep.ml (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/examples/subst.ml (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/pcre.opam (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/pre-v7.3.0-CHANGES.txt (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/src/.gitignore (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/src/Makefile (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/src/config/Makefile (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/src/config/discover.ml (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/src/config/dune (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/src/dune (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/src/pcre.ml.in (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/src/pcre.mli (100%)
 rename bundles/{pcre => pcre2}/pcre-ocaml/src/pcre_stubs.c.in (100%)

diff --git a/Makefile b/Makefile
index 55dbe849a..86a9fd058 100644
--- a/Makefile
+++ b/Makefile
@@ -101,7 +101,7 @@ PREFIX_spgen := tools/spgen/source/
 CORE_LIBS := unix str ocamlcommon \
 	$(STDCOMPATDIR)/stdcompat \
 	$(patsubst %,bytes,$(BYTESDIR)) \
-	$(patsubst %,pcre,$(filter %/pcre.cma,$(LNKLIBS)))
+	$(patsubst %,pcre2,$(filter %/pcre2.cma,$(LNKLIBS)))
 
 ifeq ($(OCAMLATLEAST50),no)
 CORE_LIBS += bigarray
@@ -121,7 +121,7 @@ LIBRARIES_spatch := $(LIBRARIES)
 
 LIBRARIES_spgen := $(CORE_LIBRARIES)
 
-CORE_BUNDLES=stdcompat menhirLib pcre
+CORE_BUNDLES=stdcompat menhirLib pcre2
 
 ALL_BUNDLES=$(CORE_BUNDLES) parmap pyml
 
@@ -214,7 +214,7 @@ MENHIR_LIB := \
 	$(addsuffix /menhirLib$(LIBSUFFIX),$(filter %/menhirLib,$(MAKELIBS)))
 PARMAP_LIB := $(addsuffix /parmap$(LIBSUFFIX),$(filter %/parmap,$(MAKELIBS)))
 PYML_LIB := $(addsuffix /pyml$(LIBSUFFIX),$(filter %/pyml,$(MAKELIBS)))
-PCRE_LIB := $(addsuffix /pcre$(LIBSUFFIX),$(filter %/pcre,$(MAKELIBS)))
+PCRE_LIB := $(addsuffix /pcre2$(LIBSUFFIX),$(filter %/pcre2,$(MAKELIBS)))
 STDCOMPAT_LIB := $(STDCOMPATDIR)/stdcompat$(LIBSUFFIX)
 
 STDCOMPAT_USERS := parsing_c/type_annoter_c cocci parsing_cocci/check_meta \
@@ -319,8 +319,8 @@ install-spatch : spatch$(TOOLS_SUFFIX)
 		$(INSTALL_PROGRAM) bundles/pyml/dllpyml_stubs.so \
 			$(DESTDIR)$(LIBDIR); \
 	fi
-	if test -f bundles/pcre/dllpcre_stubs.so; then \
-		$(INSTALL_PROGRAM) bundles/pcre/dllpcre_stubs.so \
+	if test -f bundles/pcre2/dllpcre_stubs.so; then \
+		$(INSTALL_PROGRAM) bundles/pcre2/dllpcre_stubs.so \
 			$(DESTDIR)$(LIBDIR); \
 	fi
 	$(INSTALL_PROGRAM) spatch$(TOOLS_SUFFIX) $(DESTDIR)$(BINDIR)/spatch
@@ -521,11 +521,10 @@ endif
 ifneq ($(PCRE_LIB),)
 ifeq ($(NATIVE),yes)
 $(PCRE_LIB): $(STDCOMPAT_LIB)
-	$(MAKE) -C bundles/pcre all
-	$(MAKE) -C bundles/pcre all.opt
+	$(MAKE) -C bundles/pcre2 all
 else
 $(PCRE_LIB): $(STDCOMPAT_LIB)
-	$(MAKE) -C bundles/pcre all
+	$(MAKE) -C bundles/pcre2 all
 endif
 endif
 
diff --git a/Makefile.config.in b/Makefile.config.in
index dbafa35a5..6bad1a7a6 100644
--- a/Makefile.config.in
+++ b/Makefile.config.in
@@ -5,18 +5,18 @@
 VERSION=@PACKAGE_VERSION@
 
 # * for each library $1, add another entry in the same manner
-MAKELIBS=@MAKE_dynlink@ @MAKE_menhirLib@ @MAKE_pyml@ @MAKE_pcre@ \
+MAKELIBS=@MAKE_dynlink@ @MAKE_menhirLib@ @MAKE_pyml@ @MAKE_pcre2@ \
   @MAKE_parmap@
-LNKLIBS=@MODULES_dynlink@ @MODULES_menhirLib@ @MODULES_pcre@ @MODULES_pyml@ \
+LNKLIBS=@MODULES_dynlink@ @MODULES_menhirLib@ @MODULES_pcre2@ @MODULES_pyml@ \
   @MODULES_parmap@
 OPTLNKLIBS=@MODULESOPT_dynlink@ @MODULESOPT_menhirLib@ @MODULESOPT_pyml@ \
-  @MODULESOPT_pcre@ @MODULESOPT_parmap@
-INCLIBS=@PATH_dynlink@ @PATH_menhirLib@ @PATH_pyml@ @PATH_pcre@ \
+  @MODULESOPT_pcre2@ @MODULESOPT_parmap@
+INCLIBS=@PATH_dynlink@ @PATH_menhirLib@ @PATH_pyml@ @PATH_pcre2@ \
   @PATH_parmap@
-FLAGSLIBS=@FLAGS_dynlink@ @FLAGS_menhirLib@ @FLAGS_pyml@ @FLAGS_pcre@ \
+FLAGSLIBS=@FLAGS_dynlink@ @FLAGS_menhirLib@ @FLAGS_pyml@ @FLAGS_pcre2@ \
   @FLAGS_parmap@
 OPTFLAGSLIBS=@OPTFLAGS_dynlink@ @OPTFLAGS_menhirLib@ @OPTFLAGS_pyml@ \
-  @OPTFLAGS_pcre@ @OPTFLAGS_parmap@
+  @OPTFLAGS_pcre2@ @OPTFLAGS_parmap@
 # * end of library variables
 
 # system packages inc libs
@@ -106,7 +106,7 @@ METAINFO_DIR=@METAINFO_DIR@
 
 # selected libraries
 FEATURE_menhirLib=@FEATURE_menhirLib@
-FEATURE_pcre=@FEATURE_pcre@
+FEATURE_pcre=@FEATURE_pcre2@
 
 # Features
 FEATURE_PYTHON=@FEATURE_PYTHON@
@@ -114,7 +114,7 @@ FEATURE_OCAML=@FEATURE_OCAML@
 NO_OCAMLFIND=@SUBSTITUTED_OCAMLFIND@
 
 # Include paths
-PCREDIR=@PATH_pcre@
+PCREDIR=@PATH_pcre2@
 PARMAPDIR=@PATH_parmap@
 PYMLDIR=@PATH_pyml@
 MENHIRDIR=@PATH_menhirLib@
@@ -129,4 +129,4 @@ REGEXP_FILE=@REGEXP_FILE@
 
 MENHIR_FLAGS=@DEFAULT_MENHIR_FLAGS@
 
-OCAMLATLEAST50=@OCAMLATLEAST50@
\ No newline at end of file
+OCAMLATLEAST50=@OCAMLATLEAST50@
diff --git a/Makefile.libs b/Makefile.libs
index 96e05d26f..ed6ce302f 100644
--- a/Makefile.libs
+++ b/Makefile.libs
@@ -36,15 +36,15 @@ OPTFLAGS_pyml  = $(CFLAGS_pyml:%=-ccopt %) -cclib -lpyml_stubs
 
 # pcre library
 # Note: see the comment of the pycaml library about the double appearance of the stubs library.
-LOCAL_pcre     = $(BYTESDIR:=/bytes.cma) $(PCREDIR)/pcre.cma
-LOCALOPT_pcre  = $(BYTESDIR:=/bytes.cmxa) $(PCREDIR)/pcre.cmxa
-GLOBAL_pcre    = $(BYTESDIR:=/bytes.cma) $(PCREDIR)/pcre.cma
-GLOBALOPT_pcre = $(BYTESDIR:=/bytes.cmxa) $(PCREDIR)/pcre.cmxa
-FLAGS_pcre     = \
-	$(PCRE_LIBS:%=-ccopt %) -cclib -L$(PCREDIR) -dllib -lpcre_stubs \
-	-cclib -lpcre_stubs
-OPTFLAGS_pcre  = \
-	$(PCRE_LIBS:%=-ccopt %) -cclib -L$(PCREDIR) -cclib -lpcre_stubs
+LOCAL_pcre2     = $(BYTESDIR:=/bytes.cma) $(PCREDIR)/pcre2.cma
+LOCALOPT_pcre2  = $(BYTESDIR:=/bytes.cmxa) $(PCREDIR)/pcre2.cmxa
+GLOBAL_pcre2    = $(BYTESDIR:=/bytes.cma) $(PCREDIR)/pcre2.cma
+GLOBALOPT_pcre2 = $(BYTESDIR:=/bytes.cmxa) $(PCREDIR)/pcre2.cmxa
+FLAGS_pcre2     = \
+	$(PCRE_LIBS:%=-ccopt %) -cclib -L$(PCREDIR) -dllib -lpcre2_stubs \
+	-cclib -lpcre2_stubs
+OPTFLAGS_pcre2  = \
+	$(PCRE_LIBS:%=-ccopt %) -cclib -L$(PCREDIR) -cclib -lpcre2_stubs
 
 # dynlink library
 LOCAL_dynlink     =
diff --git a/bundles/pcre/.gitignore b/bundles/pcre2/.gitignore
similarity index 100%
rename from bundles/pcre/.gitignore
rename to bundles/pcre2/.gitignore
diff --git a/bundles/pcre/Makefile b/bundles/pcre2/Makefile
similarity index 100%
rename from bundles/pcre/Makefile
rename to bundles/pcre2/Makefile
diff --git a/bundles/pcre/bytes_compat.ml b/bundles/pcre2/bytes_compat.ml
similarity index 100%
rename from bundles/pcre/bytes_compat.ml
rename to bundles/pcre2/bytes_compat.ml
diff --git a/bundles/pcre/pcre-ocaml/.gitignore b/bundles/pcre2/pcre-ocaml/.gitignore
similarity index 100%
rename from bundles/pcre/pcre-ocaml/.gitignore
rename to bundles/pcre2/pcre-ocaml/.gitignore
diff --git a/bundles/pcre/pcre-ocaml/CHANGES.md b/bundles/pcre2/pcre-ocaml/CHANGES.md
similarity index 100%
rename from bundles/pcre/pcre-ocaml/CHANGES.md
rename to bundles/pcre2/pcre-ocaml/CHANGES.md
diff --git a/bundles/pcre/pcre-ocaml/LICENSE.md b/bundles/pcre2/pcre-ocaml/LICENSE.md
similarity index 100%
rename from bundles/pcre/pcre-ocaml/LICENSE.md
rename to bundles/pcre2/pcre-ocaml/LICENSE.md
diff --git a/bundles/pcre/pcre-ocaml/Makefile b/bundles/pcre2/pcre-ocaml/Makefile
similarity index 100%
rename from bundles/pcre/pcre-ocaml/Makefile
rename to bundles/pcre2/pcre-ocaml/Makefile
diff --git a/bundles/pcre/pcre-ocaml/README.md b/bundles/pcre2/pcre-ocaml/README.md
similarity index 100%
rename from bundles/pcre/pcre-ocaml/README.md
rename to bundles/pcre2/pcre-ocaml/README.md
diff --git a/bundles/pcre/pcre-ocaml/dune b/bundles/pcre2/pcre-ocaml/dune
similarity index 100%
rename from bundles/pcre/pcre-ocaml/dune
rename to bundles/pcre2/pcre-ocaml/dune
diff --git a/bundles/pcre/pcre-ocaml/dune-project b/bundles/pcre2/pcre-ocaml/dune-project
similarity index 100%
rename from bundles/pcre/pcre-ocaml/dune-project
rename to bundles/pcre2/pcre-ocaml/dune-project
diff --git a/bundles/pcre/pcre-ocaml/examples/Makefile b/bundles/pcre2/pcre-ocaml/examples/Makefile
similarity index 100%
rename from bundles/pcre/pcre-ocaml/examples/Makefile
rename to bundles/pcre2/pcre-ocaml/examples/Makefile
diff --git a/bundles/pcre/pcre-ocaml/examples/README.md b/bundles/pcre2/pcre-ocaml/examples/README.md
similarity index 100%
rename from bundles/pcre/pcre-ocaml/examples/README.md
rename to bundles/pcre2/pcre-ocaml/examples/README.md
diff --git a/bundles/pcre/pcre-ocaml/examples/cloc.ml b/bundles/pcre2/pcre-ocaml/examples/cloc.ml
similarity index 100%
rename from bundles/pcre/pcre-ocaml/examples/cloc.ml
rename to bundles/pcre2/pcre-ocaml/examples/cloc.ml
diff --git a/bundles/pcre/pcre-ocaml/examples/count_hash.ml b/bundles/pcre2/pcre-ocaml/examples/count_hash.ml
similarity index 100%
rename from bundles/pcre/pcre-ocaml/examples/count_hash.ml
rename to bundles/pcre2/pcre-ocaml/examples/count_hash.ml
diff --git a/bundles/pcre/pcre-ocaml/examples/dune b/bundles/pcre2/pcre-ocaml/examples/dune
similarity index 100%
rename from bundles/pcre/pcre-ocaml/examples/dune
rename to bundles/pcre2/pcre-ocaml/examples/dune
diff --git a/bundles/pcre/pcre-ocaml/examples/pcregrep.ml b/bundles/pcre2/pcre-ocaml/examples/pcregrep.ml
similarity index 100%
rename from bundles/pcre/pcre-ocaml/examples/pcregrep.ml
rename to bundles/pcre2/pcre-ocaml/examples/pcregrep.ml
diff --git a/bundles/pcre/pcre-ocaml/examples/subst.ml b/bundles/pcre2/pcre-ocaml/examples/subst.ml
similarity index 100%
rename from bundles/pcre/pcre-ocaml/examples/subst.ml
rename to bundles/pcre2/pcre-ocaml/examples/subst.ml
diff --git a/bundles/pcre/pcre-ocaml/pcre.opam b/bundles/pcre2/pcre-ocaml/pcre.opam
similarity index 100%
rename from bundles/pcre/pcre-ocaml/pcre.opam
rename to bundles/pcre2/pcre-ocaml/pcre.opam
diff --git a/bundles/pcre/pcre-ocaml/pre-v7.3.0-CHANGES.txt b/bundles/pcre2/pcre-ocaml/pre-v7.3.0-CHANGES.txt
similarity index 100%
rename from bundles/pcre/pcre-ocaml/pre-v7.3.0-CHANGES.txt
rename to bundles/pcre2/pcre-ocaml/pre-v7.3.0-CHANGES.txt
diff --git a/bundles/pcre/pcre-ocaml/src/.gitignore b/bundles/pcre2/pcre-ocaml/src/.gitignore
similarity index 100%
rename from bundles/pcre/pcre-ocaml/src/.gitignore
rename to bundles/pcre2/pcre-ocaml/src/.gitignore
diff --git a/bundles/pcre/pcre-ocaml/src/Makefile b/bundles/pcre2/pcre-ocaml/src/Makefile
similarity index 100%
rename from bundles/pcre/pcre-ocaml/src/Makefile
rename to bundles/pcre2/pcre-ocaml/src/Makefile
diff --git a/bundles/pcre/pcre-ocaml/src/config/Makefile b/bundles/pcre2/pcre-ocaml/src/config/Makefile
similarity index 100%
rename from bundles/pcre/pcre-ocaml/src/config/Makefile
rename to bundles/pcre2/pcre-ocaml/src/config/Makefile
diff --git a/bundles/pcre/pcre-ocaml/src/config/discover.ml b/bundles/pcre2/pcre-ocaml/src/config/discover.ml
similarity index 100%
rename from bundles/pcre/pcre-ocaml/src/config/discover.ml
rename to bundles/pcre2/pcre-ocaml/src/config/discover.ml
diff --git a/bundles/pcre/pcre-ocaml/src/config/dune b/bundles/pcre2/pcre-ocaml/src/config/dune
similarity index 100%
rename from bundles/pcre/pcre-ocaml/src/config/dune
rename to bundles/pcre2/pcre-ocaml/src/config/dune
diff --git a/bundles/pcre/pcre-ocaml/src/dune b/bundles/pcre2/pcre-ocaml/src/dune
similarity index 100%
rename from bundles/pcre/pcre-ocaml/src/dune
rename to bundles/pcre2/pcre-ocaml/src/dune
diff --git a/bundles/pcre/pcre-ocaml/src/pcre.ml.in b/bundles/pcre2/pcre-ocaml/src/pcre.ml.in
similarity index 100%
rename from bundles/pcre/pcre-ocaml/src/pcre.ml.in
rename to bundles/pcre2/pcre-ocaml/src/pcre.ml.in
diff --git a/bundles/pcre/pcre-ocaml/src/pcre.mli b/bundles/pcre2/pcre-ocaml/src/pcre.mli
similarity index 100%
rename from bundles/pcre/pcre-ocaml/src/pcre.mli
rename to bundles/pcre2/pcre-ocaml/src/pcre.mli
diff --git a/bundles/pcre/pcre-ocaml/src/pcre_stubs.c.in b/bundles/pcre2/pcre-ocaml/src/pcre_stubs.c.in
similarity index 100%
rename from bundles/pcre/pcre-ocaml/src/pcre_stubs.c.in
rename to bundles/pcre2/pcre-ocaml/src/pcre_stubs.c.in
diff --git a/coccinelle.opam b/coccinelle.opam
index ce7485c7a..c07ebce0d 100644
--- a/coccinelle.opam
+++ b/coccinelle.opam
@@ -18,7 +18,7 @@ depends: [
   "ocaml"
   "menhir"
   "ocamlfind"
-  "pcre"
+  "pcre2"
   "stdcompat"
   "pyml" { >= "20171117" }
   "conf-pkg-config"
diff --git a/configure.ac b/configure.ac
index f0c585329..21072b301 100644
--- a/configure.ac
+++ b/configure.ac
@@ -145,7 +145,7 @@ dnl  add a line for each package that is
 dnl  configured via AC_CHECK_COCCI_EXTPKG
 dnl  or AC_REQ_COCCI_EXTPKG
 AC_COCCI_INIT_PKG_EMPTY([dynlink])
-AC_COCCI_INIT_PKG_EMPTY([pcre])
+AC_COCCI_INIT_PKG_EMPTY([pcre2])
 AC_COCCI_INIT_PKG_EMPTY([bytes]) dnl for recent versions of pcre on old OCaml
 AC_COCCI_INIT_PKG_EMPTY([pyml])
 AC_COCCI_INIT_PKG_EMPTY([stdcompat])
@@ -369,18 +369,18 @@ dnl    OCAML_PKG_pcre: if "local" use str package
 AC_ARG_ENABLE([pcre-syntax], AS_HELP_STRING([--enable-pcre-syntax], [enable pcre regular expression syntax (default: auto)]))
 AS_IF([test "x$enable_pcre_syntax" != "xno"],
 [dnl
-  PKG_CHECK_MODULES([PCRE], [libpcre],[AC_SUBST([HAVE_PCRE],[yes])],[AC_SUBST([HAVE_PCRE],[no])])
+  PKG_CHECK_MODULES([PCRE], [libpcre2-8],[AC_SUBST([HAVE_PCRE],[yes])],[AC_SUBST([HAVE_PCRE],[no])])
   AS_IF([test -z "$enable_pcre_syntax" -a "x$HAVE_PCRE" != xyes],
   [dnl
     AC_SUBST([enable_pcre_syntax], [no])
   ],
   [dnl
     AS_IF([test "x$enable_pcre" = "xno"], [AC_SUBST([enable_pcre], [local])])
-    AC_CHECK_COCCI_EXTPKG([pcre])  dnl  will set $enable_pcre to 'yes', 'no', or 'local'
+    AC_CHECK_COCCI_EXTPKG([pcre2])  dnl  will set $enable_pcre to 'yes', 'no', or 'local'
     AS_IF([test "x$enable_pcre" = "xyes"],
     [dnl
       AC_MSG_CHECKING([if pcre depends on bytes])
-      AS_IF([test "x`$OCAMLFIND query -r -format '%p' pcre 2>/dev/null | grep bytes`" = "xbytes"],
+      AS_IF([test "x`$OCAMLFIND query -r -format '%p' pcre2 2>/dev/null | grep bytes`" = "xbytes"],
       [dnl
         AC_MSG_RESULT([yes])
         AC_MSG_CHECKING([if bytes is an actual module])
@@ -407,14 +407,14 @@ AS_IF([test "x$enable_pcre_syntax" != xno],
     AC_MSG_NOTICE([support for pcre syntax is enabled])
   ],
   [dnl
-    AC_MSG_ERROR([the pcre feature is enabled but the pkg-config libpcre library is not found])
+    AC_MSG_ERROR([the pcre feature is enabled but the pkg-config libpcre2-8 library is not found])
   ])
 
   AC_SUBST([REGEXP_MODULE], [Regexp_pcre])
   AC_SUBST([REGEXP_FILE], [regexp_pcre.ml])
 ],
 [dnl
-  AC_COCCI_INIT_PKG_EMPTY([pcre])
+  AC_COCCI_INIT_PKG_EMPTY([pcre2])
   AC_SUBST([REGEXP_MODULE], [Regexp_str])
   AC_SUBST([REGEXP_FILE], [regexp_str.ml])
 ])
@@ -571,7 +571,7 @@ AS_IF([test "$MAKE_stdcompat"],
 AS_IF([test "$MAKE_parmap"],
   AC_CONFIG_SUBDIRS(bundles/parmap))
 
-AS_IF([test "$MAKE_pcre"],
+AS_IF([test "$MAKE_pcre2"],
   [AS_IF([test "x$OCAMLATLEAST4030" = xno  ],
     [AC_SUBST([CAMLnoreturn_start], [])
      AC_SUBST([CAMLnoreturn_end], [])],
@@ -595,8 +595,8 @@ AS_IF([test "$MAKE_pcre"],
      AC_SUBST([noalloc], [[[@@noalloc]]])
      AC_SUBST([untagged], [[[@untagged]]])])
   AC_CONFIG_FILES([
-    bundles/pcre/pcre-ocaml/src/pcre.ml
-    bundles/pcre/pcre-ocaml/src/pcre_stubs.c
+    bundles/pcre2/pcre2-ocaml/src/pcre2.ml
+    bundles/pcre2/pcre2-ocaml/src/pcre2_stubs.c
   ])])
 
 dnl
@@ -634,7 +634,7 @@ python scripting: $enable_python	(overridable with --enable-python)
 
 pcre regexes:     $enable_pcre_syntax	(overridable with --enable-pcre-syntax)
 pcre module:      $enable_pcre	(for local package use --disable-pcre)
-pcre library:     $HAVE_PCRE	(requires the libpcre-ocaml-dev package)
+pcre library:     $HAVE_PCRE	(requires the libpcre2-ocaml-dev package)
 
 optimized spatch: $enable_opt	(overridable with --disable-opt)
 
diff --git a/globals/regexp_pcre.ml b/globals/regexp_pcre.ml
index d09f8528f..4fa1b61b5 100644
--- a/globals/regexp_pcre.ml
+++ b/globals/regexp_pcre.ml
@@ -5,7 +5,7 @@
  *)
 
 type regexp =
-    Pcre of int (* Pcre.regexp *)
+    Pcre2 of int (* Pcre2.regexp *)
   | Str of Str.regexp
 
 (* A table is used because PCRE regular expressions are not comparable.
@@ -26,16 +26,16 @@ let regexp string =
     begin
       let c = !pcre_ctr in
       pcre_ctr := !pcre_ctr + 1;
-      Hashtbl.add pcre_table c (Pcre.regexp string);
-      Pcre c
+      Hashtbl.add pcre_table c (Pcre2.regexp string);
+      Pcre2 c
     end
   else Str (Str.regexp string)
 
 let string_match regexp string =
   match regexp with
-      Pcre regexp ->
+      Pcre2 regexp ->
 	let regexp = Hashtbl.find pcre_table regexp in
-	Pcre.pmatch ~rex:regexp string
+	Pcre2.pmatch ~rex:regexp string
     | Str regexp ->
       try
 	ignore(Str.search_forward regexp string 0);
diff --git a/install.txt b/install.txt
index a0a44bba1..2fe5e0de4 100644
--- a/install.txt
+++ b/install.txt
@@ -30,13 +30,13 @@ On Debian/Ubuntu, install the following packages:
     If you do not install libparmap-ocaml-dev, then you will automatically use
     the bundle instead. However, if you used opam to switch to a different
     version of OCaml, you must uninstall libparmap-ocaml-dev.
- - libpcre-ocaml-dev (optional, for PCRE support, bundled)
-    If you do not install libpcre-ocaml-dev, then you will automatically use the
+ - libpcre2-ocaml-dev (optional, for PCRE support, bundled)
+    If you do not install libpcre2-ocaml-dev, then you will automatically use the
     bundle instead. However, in order for the bundle to work, you also need:
-  - libpcre3-dev (optional, not bundled)
+  - libpcre2-dev (optional, not bundled)
      Additionally, if you used opam to switch to a different version of OCaml and
-     want PCRE support, then make sure you have libpcre-ocaml-dev uninstalled and
-     libpcre3-dev installed, otherwise Coccinelle will not compile.
+     want PCRE support, then make sure you have libpcre2-ocaml-dev uninstalled and
+     libpcre2-dev installed, otherwise Coccinelle will not compile.
 
 On Fedora, install the following packages:
  - automake
@@ -47,16 +47,16 @@ On Fedora, install the following packages:
  - ocaml-findlib-devel
  - ocaml-ocamldoc
  - ocaml-menhir (optional, bundled)
- - ocaml-pcre-devel (optional, bundled)
+ - ocaml-pcre2-devel (optional, bundled)
     Note: if you used opam to switch to a different version of OCaml, installing
-    ocaml-pcre-devel will make compilation impossible. Additionally, PCRE
+    ocaml-pcre2-devel will make compilation impossible. Additionally, PCRE
     support and OCaml scripting will be impossible.
 If you want Python scripting: Coccinelle is not compatible with Python 3.13,
 which is the default on Fedora as of 2024-12-19. Consider switching to Python
 3.12, for example.
 
 On Arch Linux, install the following packages:
-$ pacman -Syu pkg-config ocaml ocaml-findlib autoconf automake pcre make
+$ pacman -Syu pkg-config ocaml ocaml-findlib autoconf automake pcre2 make
 as well as the C compiler of your choice.
 Note: if you used opam to switch to a different version of OCaml, OCaml
 scripting will be impossible.
diff --git a/setup/fake-subst.sh b/setup/fake-subst.sh
index eb999d3ec..2aa2a2702 100755
--- a/setup/fake-subst.sh
+++ b/setup/fake-subst.sh
@@ -19,7 +19,7 @@ set -e
 # the next lines in the file.
 
 # the replies file assumes that the
-# libpcre and python libraries are installed, and
+# libpcre2 and python libraries are installed, and
 # that none of the optional ocaml libraries are
 # installed.
 
@@ -102,9 +102,9 @@ pythonlibs() {
   echo "-L${prefix}/lib -lpython${version}"
 }
 
-# succeeds only if "/usr/include/pcre.h" exists
+# succeeds only if "/usr/include/pcre2.h" exists
 checkpcre() {
-  test -f /usr/include/pcre.h
+  test -f /usr/include/pcre2.h
 }
 
 # iterate through pattern-response pairs

base-commit: cca22217d1b4316224e80a18d0b08dd351234497
