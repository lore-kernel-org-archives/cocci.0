Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3727DC4829B
	for <cocci@archiver.kernel.org>; Sun, 11 Feb 2024 09:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Nen0Vl2rfs0c3YUJ4gng3lP2czb05HNqbWloiwny7Os=;
  b=jlspTj6kEmJrE70dlum8BlgbDp/D4yWPJeXqPoMHXSIzbwgXcjGEcChu
   rVvBj5CL1gmWVIuMyv61634YPt0xTU8aPfEouI79xlj+j1/ElSbnOPTve
   istafZjWEogNZHbZxBpFnI0ug7CuUpPNeufvbLG6Z6iNfu8/Wt+nS/QGs
   0=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,260,1701126000"; 
   d="c'?scan'208";a="151350751"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2024 10:55:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6773EE0CD5; Sun, 11 Feb 2024 10:55:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C0E96E008A
	for <cocci@sympa.inria.fr>; Sun, 11 Feb 2024 10:55:29 +0100 (CET)
IronPort-SDR: 65c89990_Ck2yJKSunrGP3rOUztpYw1v1RY8nltJ7tPwEd3O4yyfT6Nr
 PG3Iq0jkieGGHqrzm4UbllzjIW9ZfnODyeR5qWQ==
X-IPAS-Result: =?us-ascii?q?A0ExAACtmMhlhw4P49RaHAEBAQEBAQcBARIBAQQEAQGBe?=
 =?us-ascii?q?wcBAQsBgjh8A1MyBAtIhFOIHYkcLQOEO5d1gVYUgSw+CAcBAwENNA0BAgQBA?=
 =?us-ascii?q?QMEgguCdAKHVwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEjFwcOECeFbA2CXAEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCD?=
 =?us-ascii?q?TpCAQICASMEGQEBEScECwtCAgICVAYBFAEBgnwBgioBAw4jBw2xZ38zgQGCC?=
 =?us-ascii?q?gEBBq9aHywiVoFaBwMGgUgBiCUBhSRLhDsnD4FVRIEVJ4JSMT6CQwcXBBiBC?=
 =?us-ascii?q?QgBEgGDfIJoghiDO4MwYoRsj1dUgRwDgQUEXA0bEB43ERATDQMIbh0CMToDB?=
 =?us-ascii?q?QMEMgoSDAsfBVQDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDB?=
 =?us-ascii?q?gMKMQcpVUEMUANkHzIJPAsEDBoCGxsNJCMCLD4DERACFgMdFgQyEQkLJgMqB?=
 =?us-ascii?q?jYCEgwGBgZdCRoHDwkEJQMIBAMrKQMhM0ERAwQKAxMHCwd4ggmBPQQTRAMQg?=
 =?us-ascii?q?TRChHyEagMZKx02CgIBC209NQkLGwYiAR+eEQGCCCUhgQ0BK3tKbRakFKEJN?=
 =?us-ascii?q?AeCNIFggWEMhGWDLIIKlR0GEy+EBYx4hjEOBpJemFcgjU+bCIFjOmxwMxokg?=
 =?us-ascii?q?zZPAxkPjiAZhBSEYYpmQjUCAQgwAgcBCgEBAwmFRgEBg1pnXwEB?=
IronPort-PHdr: A9a23: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
 /DQmai1JDoQq7o8HOMZANXIbt2KOjwtPEixcAM=
IronPort-Data: A9a23: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
 5tV05nR6srv
IronPort-HdrOrdr: A9a23:Kwsol6/emgI3COZ70dVuk+AAI+orL9Y04lQ7vn2ZOiYlEPBw9v
 rDoB1/73TJYVkqNk3I9erwX5VoBEmsk6KdgrNxAV7BZmbbUQKTRekO0WKh+UyFJ8SUzJ8/6U
 4PSdkaNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9JzjJjtWLT2DcMtbnn5E4+ugYzVLrIIqP/AEKK
 Y=
X-Talos-CUID: 9a23:EyOzLGBydIsjryP6ExZ7624vHsUpSWDQ3FzwHFf/GTpHWITAHA==
X-Talos-MUID: 9a23:PdLXCQhZy36YRMm8yogt1sMpN8Vp2JmqJms0ybJb4e+aMDdoJRnek2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,260,1701126000"; 
   d="c'?scan'208";a="79308411"
X-MGA-submission: =?us-ascii?q?MDFNTbRM3YZW+nNpHiI8NKI9XOPmLbzGicfees?=
 =?us-ascii?q?GknYKfy3xjHMXsB5sNFMVBbgVGGsUVgK5p/9vg/ktsclms/zS6oiu9Fp?=
 =?us-ascii?q?tr7CfXnNeCgqOBqt4l+mFwQg3rRTI/B9y6O2xDCpEk316D5J4hIfa6HP?=
 =?us-ascii?q?/or77rj1Wum/waxZRVwLcXRw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 10:55:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707645327; x=1708250127; i=markus.elfring@web.de;
	bh=WH71dhkgmsQkxDAFajygDMuXliLzdahY/TqupOk7W80=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=wNKKRh5iMfyMiFwWKGjuz7PxhLmnmWEB/1zOnhDDWhFKr1LHq/+YVEfkAM49J13p
	 e/G3UrT+RXal7ucNU/y8xj4WgghqU7TBP9cRRVVRmLTCVWtE7zprSy3XTkRKvsY9j
	 mtDLkOsf5QwNG0RDWRwXQjQvMfZJPxLsAujJyJNMtSvJz6Cg9po/Bhxd90c3lF0wi
	 qVn5BGc3C1ALr72AtgK17/ia897UZON8ENg9Tto2aSKiKnbwV8ct2+UWGNItwhW83
	 j8KFQgD/a5laG36bfz6XE//PH6K4iysWmZ8TOIsnxAuABlXCzsqttqawZv6TbJ3kF
	 IAqCrVtyy4gUpu/9yg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxYXF-1qkgfG2n0b-00xw63; Sun, 11
 Feb 2024 10:55:27 +0100
Content-Type: multipart/mixed; boundary="------------I5f43xVtbl0JEJ8CRff0KBlV"
Message-ID: <3c9ba0a0-d428-42c3-a6d0-08d2d27780f4@web.de>
Date: Sun, 11 Feb 2024 10:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
 <alpine.DEB.2.22.394.2402110938330.53569@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402110938330.53569@hadrien>
X-Provags-ID: V03:K1:yVkM3OafNL3NgBp4fYL+zyC+8Ln+h/OWqMu5N/zNilyhNAN46yV
 Fo6AqlnpHLLTZRkGUowbRHzXgIQIa/FYfNTp+q7j1QYMnDFm0ZQkCvzF5WfnDggKy/FN1Mt
 8ONC3N2tRFfgHlOMAVUdUIoY+awKq/NpISO6KUo+pJB0p9nOKnTJUx+rvPXgtMcIBQW4n8K
 TQROOib8tX+vTIW2CLsLg==
UI-OutboundReport: notjunk:1;M01:P0:xYGDyEFZBeg=;TxwwH7BeIEJ5eEjNOeroIg4pqq9
 IDLEFX3tJrfuW9ZPR3XuCTjrLLCS0uGOBaiyQRJLWbf9HYIi1iZvk9HMqVBCPhqojutGJKD63
 li9+pxiERGRL039tSjDbGZvRwtrtBz177LyhL4zTI4iUAcpLHNoTufiUepZ30DHrVe4AaZ9Y6
 b/zZj4FON//LbSNUKOyiwoADhBVzVDDmokjEsJmGRzUNtKRzov5Hgj0FIlzwbUkE3qXBdHAcv
 /aqFz7zUl7iYIHYgGSqmZYibLxhwFGy/y/O6/J4gNC3gLxwoW3aIE+dn38Ypv3C4HH8jtgmjw
 iF+YmwTrUBEyV0woMgdmcy3KDWf/k1rFfjvQ8ei3yHnIwzuxPDk6vN7+Bsw2esTWxn808d4Jd
 fHtyehWTL0w4fq/SP5FcX37db8Dr2uH16HSWw3xw3c/11z6kIZooogNBUabdcENevwoAxiF1I
 ZVlRv8OxQJA0jgxmo8pQzjQ0oAtbq+i0Qi7IGV6KnsBWAuUXKYHhu2oEzQxPeui3VTUVO6IHH
 CMa69POq+UEJgV0/Z23A5KXWA/RXonyOrsDz4K6nJteGq5KVcT1J7uzPRnamVCj8MFYki2H75
 VxusWjIfZRJPB/ouz9uSeol2H7uen/BFxYMKbh/eXOPe2TZSpoERFNPWQhMv1oRHWYVh5O725
 ucVB0P63jA95OudOmkRK09uEzfg86+iD0QMPSy/dOrfA8z0d3g1XCRPr6dC3q3DczSeDeCYaO
 UD+/qk4yKakmw+lP7TVxUWmgvny7HbvN+CnIB+qVeVDcJWT2DdNgCRKqrmfiO4G+6GP1wHNxz
 lMrXlkP5BPKjksRIOeZiGjCvnj9NTm75lO5odMnxXv9QE=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1543
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/3c9ba0a0-d428-42c3-a6d0-08d2d27780f4%40web.de>

This is a multi-part message in MIME format.
--------------I5f43xVtbl0JEJ8CRff0KBlV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> Will such data achieve any software improvements?
>
> Since you haven't provided any test data and since the file that you
> reference is not part of Linux 6.8-rc3,

I referred to a source file from the software =E2=80=9CLinux next-20240209=
=E2=80=9D
which is obviously available.


> I'm not going to look into this.

I suggest to reconsider this response.


> First, please use --debug --verbose-ctl-engine and see if you can figure
> out the answer yourself from the output.

I hope that development interests will grow for better software run time c=
haracteristics.


> If you can't figure out the answer and you want to pursue this, please
> send back one email that includes both the esmntic patch above and a
> single function that illustrates the problem.

Would you become interested to extend software tests also together with
the attached two files?


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> time spatch ..=
/Probe/slab-depot-excerpt-20240209.c delete_redundant_if_statement4.cocci
=E2=80=A6
real    0m0,249s
user    0m0,221s
sys     0m0,018s


Regards,
Markus

--------------I5f43xVtbl0JEJ8CRff0KBlV
Content-Type: text/plain; charset=UTF-8;
 name="delete_redundant_if_statement4.cocci"
Content-Disposition: attachment;
 filename="delete_redundant_if_statement4.cocci"
Content-Transfer-Encoding: base64

QHNwZWNpZmljX2RlbGV0aW9uQAppZGVudGlmaWVyIHZhcjsKc3RhdGVtZW50IHM7CkBACigg
aWYgKHZhciAhPSBWRE9fU1VDQ0VTUykKICAgICByZXR1cm4gdmFyOwomIHMKKQogLi4uIHdo
ZW4gIT0gdmFyCi0gcwo=
--------------I5f43xVtbl0JEJ8CRff0KBlV
Content-Type: text/x-csrc; charset=UTF-8; name="slab-depot-excerpt-20240209.c"
Content-Disposition: attachment; filename="slab-depot-excerpt-20240209.c"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovKgogKiBDb3B5cmln
aHQgMjAyMyBSZWQgSGF0CiAqLwovLyBTZWUgYWxzbzoKLy8gQ29udHJpYnV0aW9uIGJ5IE1h
dHRoZXcgU2FrYWkgZnJvbSAyMDIzLTExLTE2Ci8vIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0L2Ry
aXZlcnMvbWQvZG0tdmRvL3NsYWItZGVwb3QuYz9pZD03ODlkOThmN2Y1ZWM3ZjA5NGQ4NGVh
MjhiNjM0MDRjY2ZkYjQ4YTFmCi8vCi8vIGRlbGV0ZWQgcGFydApzdGF0aWMgaW50IGFsbG9j
YXRlX2NvbXBvbmVudHMoc3RydWN0IHNsYWJfZGVwb3QgKmRlcG90LAoJCQkgICAgICAgc3Ry
dWN0IHBhcnRpdGlvbiAqc3VtbWFyeV9wYXJ0aXRpb24pCnsKCWludCByZXN1bHQ7Cgl6b25l
X2NvdW50X3Qgem9uZTsKCXNsYWJfY291bnRfdCBzbGFiX2NvdW50OwoJdTggaGludDsKCXUz
MiBpOwoJY29uc3Qgc3RydWN0IHRocmVhZF9jb25maWcgKnRocmVhZF9jb25maWcgPSAmZGVw
b3QtPnZkby0+dGhyZWFkX2NvbmZpZzsKCglyZXN1bHQgPSB2ZG9fbWFrZV9hY3Rpb25fbWFu
YWdlcihkZXBvdC0+em9uZV9jb3VudCwgZ2V0X2FsbG9jYXRvcl90aHJlYWRfaWQsCgkJCQkJ
IHRocmVhZF9jb25maWctPmpvdXJuYWxfdGhyZWFkLCBkZXBvdCwKCQkJCQkgc2NoZWR1bGVf
dGFpbF9ibG9ja19jb21taXQsCgkJCQkJIGRlcG90LT52ZG8sICZkZXBvdC0+YWN0aW9uX21h
bmFnZXIpOwoJaWYgKHJlc3VsdCAhPSBWRE9fU1VDQ0VTUykKCQlyZXR1cm4gcmVzdWx0OwoK
CWRlcG90LT5vcmlnaW4gPSBkZXBvdC0+Zmlyc3RfYmxvY2s7CgoJLyogYmxvY2sgc2l6ZSBt
dXN0IGJlIGEgbXVsdGlwbGUgb2YgZW50cnkgc2l6ZSAqLwoJQlVJTERfQlVHX09OKChWRE9f
QkxPQ0tfU0laRSAlIHNpemVvZihzdHJ1Y3Qgc2xhYl9zdW1tYXJ5X2VudHJ5KSkgIT0gMCk7
CgoJZGVwb3QtPnN1bW1hcnlfb3JpZ2luID0gc3VtbWFyeV9wYXJ0aXRpb24tPm9mZnNldDsK
CWRlcG90LT5oaW50X3NoaWZ0ID0gdmRvX2dldF9zbGFiX3N1bW1hcnlfaGludF9zaGlmdChk
ZXBvdC0+c2xhYl9zaXplX3NoaWZ0KTsKCXJlc3VsdCA9IHVkc19hbGxvY2F0ZShNQVhJTVVN
X1ZET19TTEFCX1NVTU1BUllfRU5UUklFUywKCQkJICAgICAgc3RydWN0IHNsYWJfc3VtbWFy
eV9lbnRyeSwgX19mdW5jX18sCgkJCSAgICAgICZkZXBvdC0+c3VtbWFyeV9lbnRyaWVzKTsK
CWlmIChyZXN1bHQgIT0gVkRPX1NVQ0NFU1MpCgkJcmV0dXJuIHJlc3VsdDsKCgoJLyogSW5p
dGlhbGl6ZSBhbGwgdGhlIGVudHJpZXMuICovCgloaW50ID0gY29tcHV0ZV9mdWxsbmVzc19o
aW50KGRlcG90LCBkZXBvdC0+c2xhYl9jb25maWcuZGF0YV9ibG9ja3MpOwoJZm9yIChpID0g
MDsgaSA8IE1BWElNVU1fVkRPX1NMQUJfU1VNTUFSWV9FTlRSSUVTOyBpKyspIHsKCQkvKgoJ
CSAqIFRoaXMgZGVmYXVsdCB0YWlsIGJsb2NrIG9mZnNldCBtdXN0IGJlIHJlZmxlY3RlZCBp
bgoJCSAqIHNsYWJKb3VybmFsLmM6OnJlYWRfc2xhYl9qb3VybmFsX3RhaWwoKS4KCQkgKi8K
CQlkZXBvdC0+c3VtbWFyeV9lbnRyaWVzW2ldID0gKHN0cnVjdCBzbGFiX3N1bW1hcnlfZW50
cnkpIHsKCQkJLnRhaWxfYmxvY2tfb2Zmc2V0ID0gMCwKCQkJLmZ1bGxuZXNzX2hpbnQgPSBo
aW50LAoJCQkubG9hZF9yZWZfY291bnRzID0gZmFsc2UsCgkJCS5pc19kaXJ0eSA9IGZhbHNl
LAoJCX07Cgl9CgoJaWYgKHJlc3VsdCAhPSBWRE9fU1VDQ0VTUykKCQlyZXR1cm4gcmVzdWx0
OwoKCXNsYWJfY291bnQgPSB2ZG9fY29tcHV0ZV9zbGFiX2NvdW50KGRlcG90LT5maXJzdF9i
bG9jaywgZGVwb3QtPmxhc3RfYmxvY2ssCgkJCQkJICAgIGRlcG90LT5zbGFiX3NpemVfc2hp
ZnQpOwovLyBkZWxldGVkIHBhcnQKCglyZXR1cm4gVkRPX1NVQ0NFU1M7Cn0KLy8gZGVsZXRl
ZCBwYXJ0Cg==

--------------I5f43xVtbl0JEJ8CRff0KBlV--
