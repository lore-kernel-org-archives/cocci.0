Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A187AC282EC
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=jDjtgr5M03sklWjZqj4B9gL5fLlGsFuxnhRAsO5UK3c=;
  b=LummchYoRf2s6LoSG9h8BV+tP2FhuII9SS8OizXBdaqhncfuEaUx3A5p
   1X1Po7+9tX2m4RjV65jnneIzSFWi7dToAMaS1jxP10yssb+Bj+psz1pF+
   nEFmsQYkcLnf/fowBl0i28BOtP3ep+BPTJHhXEafp5jnC5Gl7bZpAmGEh
   o=;
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
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="213301065"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2025 16:09:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82FA8E0D1E; Mon, 17 Mar 2025 16:09:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 98A81E0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 16:09:49 +0100 (CET)
IronPort-SDR: 67d83b3d_IYO2BpCr5nS1P+Hj+KKdrz7Juk+ztOHbZTfLVi3XB3Nnyg/
 8+5Qik22mkkxDFTs/Lc8QRhTt+w7pJ5WQd2Cxwg==
X-IPAS-Result: =?us-ascii?q?A0F3AgC2OthnjduSqVFagQmBUwKCQn1ZNAcISIgljiKeF?=
 =?us-ascii?q?4F+DwEDAQ01DwQBAQMBA4UAiyACHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAQEBOQUXMoVMLw1JARABggA7ghYsDTd0CwEHB?=
 =?us-ascii?q?gEBOFB/gwIBgmQHrTSBATOBAYIMAQEGgQiBYNk4gWUJgUiFbYJjAYR8bwGEd?=
 =?us-ascii?q?ycbgg2BFAGBO4cFhi+CM4M9gWqBbIdigmgcLYIlgn6XSkiBBRwDWSwBVRMNC?=
 =?us-ascii?q?gsHBYFsAzUMCy4VgUVDN4JDaUk6Ag0CNYIbfIIohE2EPIQ/hVCCEYIFiSyEY?=
 =?us-ascii?q?S1QgRUdQAMLGA1IESw3FBsGPm4HoXUBOoRCAYEOAS8rbDESHzQMxlaCP4Fmg?=
 =?us-ascii?q?WOKNZUwGjOBS4I4gVeLMoY6DpMDmH6kS4RogWc6gVwzGggcFIMiCUYDGQ+Ne?=
 =?us-ascii?q?AExEAmBSYJCgiO+VEUyPAIHCwEBAwmJAIccgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b0biodND62rNqQvhJYU
IronPort-HdrOrdr: A9a23:VEimXKiLGhuU0dFJGzjNl4+ID3BQXgMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJhGo6H5BEDgewKmyXcR2+Z+AV7MZniDhILFFvAA0WKA+UyYJ8SdzJ876U
 4IScEXaOEYZmIK6PoSjjPIcerIuOP3lpyAtKPk/FkoZT1WSshbjjtRO0KhIWMzbixvP6B8NL
 f03KZ6mwY=
X-Talos-CUID: 9a23:VrYvFmxSKmtiEhrJZamaBgU4Q5gXdn3R9k73KmPlF0Y1QbaJYFm5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A0YS6IA2+CVbNLYSSpTXwq6MzbDUj6vSREx0ut5U?=
 =?us-ascii?q?/oPKOGwlNJiWthTu2a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="213301039"
X-MGA-submission: =?us-ascii?q?MDFBgfBxhjmNAKVPg7s0J/GxvLcVPVfhigSK6A?=
 =?us-ascii?q?offWgZzXGVHRyAR/Jcd6b+qomncniXp2zuzaX8Cuj9V9km2c+kVAbyHH?=
 =?us-ascii?q?kAfL5uLrFkHGUpcrB38rHmozdKQ/uW2o2GVzdXGY3alwvekji8+SJwWb?=
 =?us-ascii?q?VR/iJdMeyzmzpopSD/aHB+oQ=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 16:09:49 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742224188; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G+jml9JkXhFzDggs9f3bwM2avwZ4EcdUfxo6H/YHzPkv5Koto7WvD3r/nj/Wz/lL5j
    cIykt9E3KA8pA9yzfvL70y1PwA4yCK7bRevhItzIoAync91ck1ldyTjNrjTfEobwqX/4
    IuJTcxJwRGzpWgJ48j8b5MJWpH7OIPc1Ou2jiQB0G6z//hxFgS4BD8unh3/pmrl8xALr
    SCsSGpFrY/U5AJIAE2UH/1GZIsGxhfbABfWLyPyTymRvRnMFYYI0/tTuKAQo/eqJqpyV
    eKigq3GFw7LOHJOq+gzfs4C0t1dhKpRUkyD61fnETv2OV6UJiYfyN7pxGOw2VagjzsOk
    yzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742224188;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=jDjtgr5M03sklWjZqj4B9gL5fLlGsFuxnhRAsO5UK3c=;
    b=B2hBGfuXMYQ+R2QV3J5U3tEhgo7XXt6444EGX7OIE+65fcV2cPvIRGoFL2QWm/Y4wJ
    MI+L4TDm3mgsCGvn8+e7276jUVFXIIJsP55fQnMCnOMYMwhXEMpIO4e4okHVlf0kbcMS
    u8LxeKVhqGBmrz3r9RblhPJjJu96iXBl0u4YI/MTiSYMNpkldQaCU1a980cV31G4tp7E
    FOaWcLw+1EVwBHiL1sSyF60DXMhDKzTn6ioP9SnNT7oVaxR2UboKRtiyFhUWpLgbhp+O
    OXMmPKzWpQ5ehCXyml3wCuk7N6oXGfu6VxGUAAoVoGMzBRvDt5DIX/B+YemYtB8uJc75
    wdTw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742224188;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=jDjtgr5M03sklWjZqj4B9gL5fLlGsFuxnhRAsO5UK3c=;
    b=dgQ2W41ePVJPQV1EoC0oetEBktIxeeDYGdPMr62qykOuTLV8C2CmHD6Vuux7GmKFYr
    hphuoMepg9okYK6brK7SO5DkCr2AaNqFeJ75/z5DJULH8JXmKPMfvFRlANPxuoYkWqXl
    tlI5pkagT8xaolGlaHAqiwhwbh3FVqYepjJfExJkxGpHcT61Mybj3KoRvVgiWXc6+0hk
    Z5ZRQgWth7UwtjbWHue2xUy1ZhS1gKlbJcqPf77P7/RJtpvECLwg93npVgkH5/WAhOTo
    xCG+7/by5wHnGJ9edDtocy67XPb5Bf+8Qgpb1aj57ZERzrFwUe/iAXUqB2zNdIXDEYPo
    QBMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742224188;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=jDjtgr5M03sklWjZqj4B9gL5fLlGsFuxnhRAsO5UK3c=;
    b=b1RSqq9gaphAXwdAiDo75apU0YsY9Xlii+yC3yVCXX6G8JY+jTCke0NYj3nzwgUcR5
    UCGG4aQ2URMvL8q1DfDg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSVYjagMyZmkab3cQQk8ITYm/c/zHbXf6Nw2MS9"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12HF9mx2p
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Mon, 17 Mar 2025 16:09:48 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Date: Mon, 17 Mar 2025 16:08:17 +0100
Message-ID: <20250317150941.32415-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Subject: [cocci] [PATCH v1] replace pcre with pcre2
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2587
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250317150941.32415-1-olaf%40aepfle.de>

Since pcre is unmaintained, I was asked to remove usage of ocaml-pcre.

This is the minimal change to use ocaml-pcre2. The question is what kind
of change the maintainers want to see here. There are 5 possible
variantes to support regular expressions: Str.regex, Pcre, Pcre2, Re and
Re2.

This patch just exchanges one with another. Would there be some benefit to
support all five in a single binary, for correctness and/or performance
comparison?

Please let me know how to proceed.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 Makefile               |  6 +++---
 Makefile.config.in     | 18 +++++++++---------
 Makefile.libs          | 18 +++++++++---------
 configure.ac           | 14 +++++++-------
 globals/regexp_pcre.ml | 10 +++++-----
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/Makefile b/Makefile
index 55dbe849a..0c45127bd 100644
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
diff --git a/configure.ac b/configure.ac
index f0c585329..234d46fb4 100644
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

base-commit: cca22217d1b4316224e80a18d0b08dd351234497
