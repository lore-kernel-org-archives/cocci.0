Return-Path: <SRS0=z9nG=EQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF925C388F7
	for <cocci@archiver.kernel.org>; Tue, 10 Nov 2020 15:11:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C441920659
	for <cocci@archiver.kernel.org>; Tue, 10 Nov 2020 15:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ig/dQFN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C441920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AAFBD1O004158;
	Tue, 10 Nov 2020 16:11:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8F59D7683;
	Tue, 10 Nov 2020 16:11:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D98D8454B
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 16:11:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AAFB8JZ001739
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 16:11:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605021068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njQuqW6w+deMDF7rl74J4VrhXYVxUZmsowvCas4ZEKE=;
 b=ig/dQFN9egea7uXr2N98pIA6Z3EU6Se9khnhSLwtfGI1HAkLvPWDPhY1AqgiiibZ/SYW5s
 u77b1N++oZmjJcH0BulnwKcAdCfBfgRcRnt9sO9jMRxzzRhfScmQRyR1c933RgIvkekaZ3
 5OV735gEA3qi80znVwNphz6lYklvZx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-wT-FfslaOTGst5kBh-ktFg-1; Tue, 10 Nov 2020 10:11:04 -0500
X-MC-Unique: wT-FfslaOTGst5kBh-ktFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BAAD188C14E;
 Tue, 10 Nov 2020 15:11:03 +0000 (UTC)
Received: from foo.home.annexia.org (ovpn-114-98.ams2.redhat.com
 [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF9EF5C1C4;
 Tue, 10 Nov 2020 15:11:02 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: julia.lawall@inria.fr
Date: Tue, 10 Nov 2020 15:10:58 +0000
Message-Id: <20201110151058.82289-2-rjones@redhat.com>
In-Reply-To: <20201110151058.82289-1-rjones@redhat.com>
References: <20201110151058.82289-1-rjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 10 Nov 2020 16:11:13 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 10 Nov 2020 16:11:08 +0100 (CET)
Cc: cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH Python 10] bundles/pyml: Remove bindings for
	PyObject_As(Char|Read|Write)Buffer
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

These have been removed in Python 3.10.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1896393
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 bundles/pyml/pyml-current/py.ml        | 12 ------------
 bundles/pyml/pyml-current/py.mli       | 12 ------------
 bundles/pyml/pyml-current/pycaml.ml    |  6 ------
 bundles/pyml/pyml-current/pycaml.mli   |  3 ---
 bundles/pyml/pyml-current/pyml_stubs.c | 12 ------------
 5 files changed, 45 deletions(-)

diff --git a/bundles/pyml/pyml-current/py.ml b/bundles/pyml/pyml-current/py.ml
index fc49bc42..d33dcf77 100644
--- a/bundles/pyml/pyml-current/py.ml
+++ b/bundles/pyml/pyml-current/py.ml
@@ -36,12 +36,6 @@ external pyerr_fetch_internal: unit -> pyobject * pyobject * pyobject
     = "PyErr_Fetch_wrapper"
 external pystring_asstringandsize: pyobject -> string option
     = "PyString_AsStringAndSize_wrapper"
-external pyobject_ascharbuffer: pyobject -> string option
-    = "PyObject_AsCharBuffer_wrapper"
-external pyobject_asreadbuffer: pyobject -> string option
-    = "PyObject_AsReadBuffer_wrapper"
-external pyobject_aswritebuffer: pyobject -> string option
-    = "PyObject_AsWriteBuffer_wrapper"
 external pylong_fromstring: string -> int -> pyobject * int
     = "PyLong_FromString_wrapper"
 external pycapsule_isvalid: Pytypes.pyobject -> string -> int
@@ -1429,12 +1423,6 @@ module Object = struct
 
   let to_string item = String.to_string (str item)
 
-  let as_char_buffer obj = check_some (pyobject_ascharbuffer obj)
-
-  let as_read_buffer obj = check_some (pyobject_asreadbuffer obj)
-
-  let as_write_buffer obj = check_some (pyobject_aswritebuffer obj)
-
   external reference_count: pyobject -> int = "pyrefcount"
 
   let repr_or_string repr v =
diff --git a/bundles/pyml/pyml-current/py.mli b/bundles/pyml/pyml-current/py.mli
index 19a4599e..df509a02 100644
--- a/bundles/pyml/pyml-current/py.mli
+++ b/bundles/pyml/pyml-current/py.mli
@@ -239,18 +239,6 @@ module Object: sig
       We have
       [Py.Object.to_string o = Py.String.to_string (Py.Object.str o)]. *)
 
-  val as_char_buffer: t -> string
-  (** Wrapper for
-      {{:https://docs.python.org/3/c-api/objbuffer.html#c.PyObject_AsCharBuffer} PyObject_AsCharBuffer} *)
-
-  val as_read_buffer: t -> string
-  (** Wrapper for
-      {{:https://docs.python.org/3/c-api/objbuffer.html#c.PyObject_AsReadBuffer} PyObject_AsReadBuffer} *)
-
-  val as_write_buffer: t -> string
-  (** Wrapper for
-      {{:https://docs.python.org/3/c-api/objbuffer.html#c.PyObject_AsWriteBuffer} PyObject_AsWriteBuffer} *)
-
   val reference_count: t -> int
   (** [reference_count o] returns the number of references to the Python
       object [o]. *)
diff --git a/bundles/pyml/pyml-current/pycaml.ml b/bundles/pyml/pyml-current/pycaml.ml
index 8c93cf4a..13b16aa8 100644
--- a/bundles/pyml/pyml-current/pycaml.ml
+++ b/bundles/pyml/pyml-current/pycaml.ml
@@ -347,12 +347,6 @@ let pyunicode_asunicode = Py.String.to_unicode
 
 let pyunicode_getsize = Py.String.length
 
-let pyobject_ascharbuffer = Py.Object.as_char_buffer
-
-let pyobject_asreadbuffer = Py.Object.as_read_buffer
-
-let pyobject_aswritebuffer = Py.Object.as_write_buffer
-
 let python () =
   Py.Run.interactive ();
   0
diff --git a/bundles/pyml/pyml-current/pycaml.mli b/bundles/pyml/pyml-current/pycaml.mli
index 85b5f83c..da800bac 100644
--- a/bundles/pyml/pyml-current/pycaml.mli
+++ b/bundles/pyml/pyml-current/pycaml.mli
@@ -758,9 +758,6 @@ val pyobject_size : pyobject -> int
 val pyobject_getitem : pyobject * pyobject -> pyobject
 val pyobject_setitem : pyobject * pyobject * pyobject -> int
 val pyobject_delitem : pyobject * pyobject -> int
-val pyobject_ascharbuffer : pyobject -> string
-val pyobject_asreadbuffer : pyobject -> string
-val pyobject_aswritebuffer : pyobject -> string
 
 val pynumber_check : pyobject -> int
 val pynumber_add : pyobject * pyobject -> pyobject
diff --git a/bundles/pyml/pyml-current/pyml_stubs.c b/bundles/pyml/pyml-current/pyml_stubs.c
index 5158a0e4..cc10e821 100644
--- a/bundles/pyml/pyml-current/pyml_stubs.c
+++ b/bundles/pyml/pyml-current/pyml_stubs.c
@@ -195,12 +195,6 @@ static PyObject *Python__Py_FalseStruct;
 /* Buffer and size */
 static int (*Python_PyString_AsStringAndSize)
 (PyObject *, char **, Py_ssize_t *);
-static int (*Python_PyObject_AsCharBuffer)
-(PyObject *, const char **, Py_ssize_t *);
-static int (*Python_PyObject_AsReadBuffer)
-(PyObject *, const void **, Py_ssize_t *);
-static int (*Python_PyObject_AsWriteBuffer)
-(PyObject *, void **, Py_ssize_t *);
 
 /* Length argument */
 static PyObject *(*Python_PyLong_FromString)(const char *, const char **, int);
@@ -684,9 +678,6 @@ py_load_library(value filename_ocaml, value debug_build_ocaml)
         resolve("PyObject_CallMethodObjArgs");
     Python_PyErr_Fetch = resolve("PyErr_Fetch");
     Python_PyErr_NormalizeException = resolve("PyErr_NormalizeException");
-    Python_PyObject_AsCharBuffer = resolve("PyObject_AsCharBuffer");
-    Python_PyObject_AsReadBuffer = resolve("PyObject_AsReadBuffer");
-    Python_PyObject_AsWriteBuffer = resolve("PyObject_AsWriteBuffer");
     if (version_major >= 3) {
         Python__Py_FalseStruct = resolve("_Py_FalseStruct");
         Python_PyString_AsStringAndSize = resolve("PyBytes_AsStringAndSize");
@@ -1272,9 +1263,6 @@ pyml_wrap_ucs4_option_and_free(int32_t *buffer, bool free)
     }
 
 StringAndSize_wrapper(PyString_AsStringAndSize, char);
-StringAndSize_wrapper(PyObject_AsCharBuffer, const char);
-StringAndSize_wrapper(PyObject_AsReadBuffer, const void);
-StringAndSize_wrapper(PyObject_AsWriteBuffer, void);
 
 static FILE *
 open_file(value file, const char *mode)
-- 
2.28.0.rc2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
