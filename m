Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA0BC35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 08:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=/JLpz1xL77gX6dcZzf2G6ajVR1unxSrUH6tl3jBNI+s=;
  b=IgNrOAMkC5UkRdLoMLuME+c0DrETn3Hl5ho/PjpD+2saBrfR/FVP9ppK
   /ahd689HhgU2nt39SMiJAr+5NY3N9hdgVNaEBQjBWAUt1YX4Rdmh3vbgs
   t5KYX7OVEfofhxWu5LZ599rZlwLl9T9e0tVESqySgoFC13oMwC9v1pdAw
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
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213631424"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 09:31:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9B8F2E0261; Wed, 19 Mar 2025 09:31:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 55CA4E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 09:30:57 +0100 (CET)
IronPort-SDR: 67da80c2_zQI7hR9OnB3mkataXF1g+p89612+uDNbj2np1PEXcy/Jshj
 tP/yDHtZHVJFZTlrj6XW0/NqVvh+yCKK7buAg2w==
X-IPAS-Result: =?us-ascii?q?A0GoAQCif9pnkdmSqVFagQmBUwKCQn1ZNAcISIgljiKeF?=
 =?us-ascii?q?4F+DwEDAQ01DwQBAQMBA4UAiyICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO4VMLw1JARABggA7ghYsDTd0CwEHB?=
 =?us-ascii?q?gEBOFB/gwIBgmQHrhCBATOBAYIMAQEGgQiBYNk4gWUJgUiFbYJjAYR8bwGEd?=
 =?us-ascii?q?ycbgg2BFAGBO4cFhi+CM4M+gWqBbIdigmgcLYIlgn6Kfo0fSIEFHANZLAFVE?=
 =?us-ascii?q?w0KCwcFgWwDNQwLLhWBRUM1gkRpSToCDQI1ght8giiETYQ+hECFUIIRggWJM?=
 =?us-ascii?q?4RhLVCCFh1AAwsYDUgRLDcUGwY+bgeiOwE6hA8zARZDLAkBL4EXYgcBLAw6x?=
 =?us-ascii?q?F6BPoI/gWaBY4o1lTAaM4FLhA+RbA6TA5h+pEuEaIFnOoFcMxoIHBSDIglGA?=
 =?us-ascii?q?xkPjXgBMRAJgUmCQoIjg3quU0UyPAIHCwEBAwmJAIccgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J83q6awD7iq50Eu
IronPort-HdrOrdr: A9a23:y6XTV6HORzntiZX7pLqEMceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPHjP+U4ssRAb6Ku90cy7Lh3hHPFOkO0s1NuZLWrbUQiTXfhfBOnZslrd8kTFn4Y86U
 4KSdkaNDSfNykZsS+D2njfL/8QhOK13uSBudr+pk0NcShaL5pSwUNSLy6gKAlXaWB9aaYEKA
 ==
X-Talos-CUID: 9a23:qOHLwWNK+BtP/+5DZDhot18oBsMZbyPR1m3yDGipMk9qV+jA
X-Talos-MUID: 9a23:1VQxvQatMfw05OBTkC7zxy0/E8NUpJ+CGFwjzp8jnPelHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213631397"
X-MGA-submission: =?us-ascii?q?MDHTCb+LFs2Kv7F+7RKMnqUuL+pegIYYZ/HlqY?=
 =?us-ascii?q?rnHEDRcNWssw+hqnSPFGcRw0HKhEsfH7A5cRpfZLR8iStVY8UvTA/QQU?=
 =?us-ascii?q?wQQFEJioH4QYD0MRRR09G8Ph1z6JxavEv83eQviNAJCs3OkyRJET+0V3?=
 =?us-ascii?q?LV9rqGP08AnEGWNbB382imSg=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:30:57 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742373055; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hp4FWGlkkOw85gF84s5ubpnpw+H56Xd7BQ8YRuix14KIIeKp4Gx0x8zWiSWIAWaNJ4
    dEb0XtmG2lEnAE2JmdDfLfp7QXlCd0urHA9KlbQIdWQUuA9x9X37vwi+8AU76+8MIiOj
    GPrTuNFaH5bA7g0tOV0UmUupqKZnSVuPYYtlClprzef7MvUkH9eYVGY9y++vnXsKo8CY
    5Ga/2+CigLv77j6LmZXgUzM3b2RT1cd0Vz7/+5qaa+KMWkJS7hH7rHPK/KKfPwD1qXm5
    azuMKyhLPdCNMXMzVOSeo8AIew8QivsXPYA+9af0TqyvHqotMlwYN5pp7USeh3m+xSJp
    GBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742373055;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=/JLpz1xL77gX6dcZzf2G6ajVR1unxSrUH6tl3jBNI+s=;
    b=BUzH8HXbthggWhbP0uimJ224F1MxXiNPTTTioKKU4h+/aaIif57rxwvft5xWRW1ups
    Gz9oSxb3/n37Rs0cCtWNy5GQT6Jgj6/mnkHdDp/YvDttlHZTqLkmlozwKqoNU+anI130
    R2Mcw5s8ZYBN3+QU/3yOMsPM8vheUtxtk/s1JvQcLuocQk/zCQOCO02z6wUqDIEjXYEz
    UXrxeYGQKf1hJvU91ts3qS3ijdiacTThjbxKfE4lQO2BO0Cw0Ke3YCWFqAnuO3lvzKAW
    8ZZE+NQ3M8D5GqLFlTRFNVze08cPgBpeNbtD00MqWdpSVT8Qnfo5jB9BcUTryoDzsGy1
    Y8Jg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742373055;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=/JLpz1xL77gX6dcZzf2G6ajVR1unxSrUH6tl3jBNI+s=;
    b=d0dauXKFwzH4To0cqWfZHno+BILV+mM+XynCgBfgCCzJvjzTAgJq3ZhiQKfFD8Atbp
    akN+RShGJiFZnidoy5rIPbB2fZJMS+QkXvx7E7wGrYpExxLpxs/ULzD4ekiV+sNfSaZF
    ZgVysIY5KcdFMWGvUWwXBXHLv5KS2WrtwYY32jTHc0wh/39zr9g03IdCGnWtmfbCD/AN
    zlf89kKXXatgKzsN1jJgMwiDQTmdLzK+mZ8L/wlINvIrVHCZQ9cIYcZ6LZBVwvBAS1CD
    V57I65tg+DbWTZ5zjHs1kZC9jaWTt+z4EQKkUE8xbAMSGszVDJS80E3szYiM843RScOH
    2zEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742373055;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=/JLpz1xL77gX6dcZzf2G6ajVR1unxSrUH6tl3jBNI+s=;
    b=xo7O9kIjFqOgpNE59ZXSHBSefUaQW/cMyim+YSL8RSJmLl56Yqqxa07c3EjttCoZKy
    iIlPnjnsbZUJ3lDav9DA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSVYjagMyZmkab3cQQk8ITYm/c/zHbXf6Nw2MS9"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12J8Ut4rw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Wed, 19 Mar 2025 09:30:55 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Date: Wed, 19 Mar 2025 09:14:35 +0100
Message-ID: <20250319083051.2862-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Subject: [cocci] [PATCH v3] replace pcre with pcre2
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2636
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250319083051.2862-1-olaf%40aepfle.de>

Since pcre is unmaintained, the usage of ocaml-pcre will be replaced
with ocaml-pcre2. While other regular expession libraries for OCaml
exists, they are not as feature complete as pcre2 is.

This is the minimal change to use the system ocaml-pcre2. To reduce the
size of this patch, a separate commit might be required to import
pcre2-ocaml.git into bundles and use it in the build system.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
v3: remove changes for bundles

 Makefile               |  4 ++--
 Makefile.config.in     | 18 +++++++++---------
 Makefile.libs          | 18 +++++++++---------
 coccinelle.opam        |  2 +-
 configure.ac           | 16 ++++++++--------
 globals/regexp_pcre.ml |  6 +++---
 install.txt            | 16 ++++++++--------
 setup/fake-subst.sh    |  6 +++---
 8 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/Makefile b/Makefile
index 0b93d7428..8e7c98dc6 100644
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
index 25f510fb3..25f2aa9fa 100644
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
@@ -634,7 +634,7 @@ python scripting: $enable_python	(overridable with --enable-python)
 
 pcre regexes:     $enable_pcre_syntax	(overridable with --enable-pcre-syntax)
 pcre module:      $enable_pcre	(for local package use --disable-pcre)
-pcre library:     $HAVE_PCRE	(requires the libpcre-ocaml-dev package)
+pcre library:     $HAVE_PCRE	(requires the libpcre2-ocaml-dev package)
 
 optimized spatch: $enable_opt	(overridable with --disable-opt)
 
diff --git a/globals/regexp_pcre.ml b/globals/regexp_pcre.ml
index d09f8528f..93073758f 100644
--- a/globals/regexp_pcre.ml
+++ b/globals/regexp_pcre.ml
@@ -5,7 +5,7 @@
  *)
 
 type regexp =
-    Pcre of int (* Pcre.regexp *)
+    Pcre of int (* Pcre2.regexp *)
   | Str of Str.regexp
 
 (* A table is used because PCRE regular expressions are not comparable.
@@ -26,7 +26,7 @@ let regexp string =
     begin
       let c = !pcre_ctr in
       pcre_ctr := !pcre_ctr + 1;
-      Hashtbl.add pcre_table c (Pcre.regexp string);
+      Hashtbl.add pcre_table c (Pcre2.regexp string);
       Pcre c
     end
   else Str (Str.regexp string)
@@ -35,7 +35,7 @@ let string_match regexp string =
   match regexp with
       Pcre regexp ->
 	let regexp = Hashtbl.find pcre_table regexp in
-	Pcre.pmatch ~rex:regexp string
+	Pcre2.pmatch ~rex:regexp string
     | Str regexp ->
       try
 	ignore(Str.search_forward regexp string 0);
diff --git a/install.txt b/install.txt
index fd7e48d76..544b10d02 100644
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

base-commit: d9064ec494fa1572abc4b1e26984246ce902b7aa
