Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7591BC433FE
	for <cocci@archiver.kernel.org>; Thu, 19 May 2022 12:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rV/JIDKY1tPLQoKOcYQVFKh1Qiqztq1cCYE4CZLhs4c=;
  b=Ho3D3ekuhMXRMIzyXD30OP5j5W/ktUtJHMUUkp+CSatOkQhw8+8RouMT
   ehIs4R/EBQZrFEdL0XLPZxPolmepFAAwGx5m/ChZwAS3xmbzGLYL9Ll0A
   2HI0Zo4BzidoSt5GeTOJ0KPRlUM0eyx+qyogw7OlkDXaylUq9X+g6pljz
   8=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="5.91,237,1647298800"; 
   d="scan'208";a="37116929"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 May 2022 14:19:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8665AE437C; Thu, 19 May 2022 14:19:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ADB14E0094
	for <cocci@sympa.inria.fr>; Thu, 19 May 2022 13:55:54 +0200 (CEST)
IronPort-SDR: MdU1D0AG7lZ4Sv90TtZie5w4CheNzGEJlyAZ7jdZE+YdeIxNdzMT4o6jnZp1p1sqnNRCXeW9kj
 wLdSG59RPoJ3vIniFCztf+FX5jqnxrmnoDfrIu9k+GNdvBvoocxM+rWHUgUY9PK3u4gmUafj6N
 COhSdQCU6bIU7TLWZNfS7h5x2vLEEVnrne/y3qoMFcFhilFEwU9+uuePkcviUC9u2hIjwoY/1j
 9CCi5OJZ3BdPpcBT3RK2FXikS2kL3UJEjMdtSpCoTnuf+QOaSaz056BTL+XItcHTFY5Y6Sy+2o
 MEUz9N0WgtY6ly+yldFnd/ul
X-IPAS-Result: =?us-ascii?q?A0CdaQD5L4Zi/z4rTJBaHQEBPAEFBQECAQkBFYFHBgEDA?=
 =?us-ascii?q?YIhgQNPKwMHCEOETokApHSBewsBAwENEi0BAgQBAYpEHwYBBDcDDQECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAYEIMmRmgUGCBAYDATANgjUihBUEG?=
 =?us-ascii?q?QEBODQCJgKHB6s+fzKBAYIIAQEGgl6DK4FcCYEQLAGHPYdmgg2KDoMJgmWVQ?=
 =?us-ascii?q?x07AxwyORKBIXEBCAYGBwoFMgYCDBgUBAITElMdAhMFBwocDhQcJBkMDwMSA?=
 =?us-ascii?q?xEBBwILEggVLAgDAgMIAwIDLgIDGAkHCgMdCAocEhAUAgQTHwsIAxofLQkCB?=
 =?us-ascii?q?A4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGAwYCBQUBAyADFAMFJwcDI?=
 =?us-ascii?q?QcLJg0NBCMdAwMFJgMCAhsHAgIDAgYXBgICcQooDQgECAQcHiUTBQIHMQUEL?=
 =?us-ascii?q?wIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJxsHFhkdGQEFXQYLCSIcLBEFBhYDJ?=
 =?us-ascii?q?nkFCgpGl0KBcIJIwG2DV4FDnnuBQ5UckXqWZ6ctggsBESuBLjMaCCYKgyNOA?=
 =?us-ascii?q?QIBAgEMAQICAQIBAgECAQgBAQEBlmiGB0IxOwIGCwEBAwmFRQGKSQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:2BIzC60wZbxPGNTOZvbD5fF3kn2cJEfYwER7XKvMYLTBsI5bpzZTx
 mEaCmzQaanbamCgedF+a4vko00HscTWz9QySAtk3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywobVvqYy2YLjW17U6
 IuryyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt+1Jy
 85DsL2fchkSI5bDtcMESR97HC4raMWq+JefSZS+mdeS11bBd2bwwvJoFwcwMJFwFuRfWD0Ss
 6NGbmxWKE7Z7w616OrTpu1EhMMjJc/tMZg3oXB41jbdEOonRpbYBaPH+be02R9r2ZkXRKmHP
 aL1bxJiSijeRD8RZ24ON7Fk2/+UmiGmfABH/Qf9Sa0fuDGOk1cqi9ABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb39Nae2mn3wPTOhTj8XJ8OFbq+7bhsjUH7KnEv5AM+aGO4uve8q2GFRelCE
 EM53TM0q4s9+xn+JjXiZCGQrHmBtx8aftNfFewm9Q2AopY4BS7JXwDoqRYRMrQbWN8KqS8Ci
 wbTzoKybdB7mOzJGCvFnluBhWnqYUAowXk+iTgsYSZt3jUOiJpoyAnOVs1kFLOpj9rzAnf2z
 iziQMkCa1c70Z5jO0aTpwmvb9eQSn7hFF5dCuL/BDnN0++BTNT5D7FEEHCChRuARa7AJrV7g
 FAKmtKF8McFBoyXmSqGTY0lRe/0vabcameG3gYwT/HNEghBHVbzJOi8Bxkufi9U3josJGeBj
 LL741gLv8YCZBNGk4cuO9ztW59CIVfc+STNDamJMYEVOfCdhSeH8T18Y0OKl2frlEkqnOkwP
 J2bGftA/l5KYZmKDVOeGY8g7FPc7ntgmTKLGMqqlk3PPHj3TCf9dIrp+WCmNogRhJ5oai2Mm
 zqGH8fVmRhZTsPkZSzbrdwaIVwQdCZpHpHusMtTa/KCJQx9XmcsF6aJk78mfoVkmYVTl/vJp
 ynkAhMCkwOi2XCXex+Xbn1Daa/0Wcotp3wMIiFxb02j3GIuYNjz4f5HJYc3Z7Qu6Mdq0eVwE
 6seY8yFD/kWEmbH9j0RYIPTtotncBj31wuCMzD8PmokfoZ7QAjU5t7jeBCp8iQSV3Llucw7q
 rym9wXaXZtaH106UJyNMa/zwgro73YHme90U0/ZGfVpeR3hoNpwNij8rv4rOMVQex/N8SSXi
 lSNChACqOiT/4JsqIvVhbqJppuCGvdlGhYIBHHS6Lu7OHWI/menxoMcAu+EcSqECjHv+b25Y
 uFI0/D7NuZBmltW6tIuH7FuxKM4xt3uu74Dll08QC+QNgn3B+MyOGSC0OlOqrZJmu1TtzypV
 x/d4dJdI7iIZp/oSQZDOAo/Y+2f/vgIgT2Ov+8tKUD36XMl5raBSkkObRCAhDYEfelua8U+w
 P86v8oL9w24jAFsNNua13gG+2OJJ30GcqMmqpBDWNaz1lBwkwwebMyOEDLy7bGOd85IYxsjL
 TKjjabfg6hRmxjZeH0pGHmRhedQiPziYvyRIIPu87hIpjbEuhPz9AZQ6S8wShlJzxJByKR1N
 3QD24hdO/CV5zkx7CRcdznEJu2DLETxFo/NJ58hj2zBVE6sS3DMK2smf+CA4Cj1NkpCKyND8
 ujwJHnNCF7XkQKY4sf2cVVks+fkScFt9wrEg4ahEtjt81zWp9b6qvfGWFfkYCcLzS/8aIMra
 AWqECtNhXXHCBMt
IronPort-HdrOrdr: A9a23:nKI9W6t2vStdIOaHxhkrucTq7skDcdV00zEX/kB9WHVpm6uj5q
 OTdZUgtSMc7Qx7ZJhOo7G90cW7Lk80lqQFhLX5X43OYOCOggLBRr2KhrGP/9SPIUPDH6JmpM
 VdWpk7DNX0E1BggYLw6BqxG81I+qjizJyV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,237,1647298800"; 
   d="scan'208";a="37111712"
X-MGA-submission: =?us-ascii?q?MDGEKYmEFUDCSkTtjHkdenUcKivr2j8q6h7bnd?=
 =?us-ascii?q?i1c5rDvT1yDex1NYKA+GTZ4OR+EaVsnHNyeky1C3VululNpV+ypu8Cs1?=
 =?us-ascii?q?c7s7MXkwFlQwwgRDNVxJHrZVtmXytSFViqhLzzAxjKD7zuYKsNcRTIdg?=
 =?us-ascii?q?zy/kj79lwzTBNHy9BU/azMFg=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([144.76.43.62])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:55:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=rV/JIDKY1tPLQoKOcYQVFKh1Qiqztq1cCYE4CZLhs4c=; t=1652961354; x=1654170954; 
	b=N9+A7DiEWWhz3tIg2lQJKqkhkRY3pWqwsUI2iFSD1hecMguOTcAET4+Ruqxm5znPje4WAo1haX/
	VDBkeLXyI9qd+9xye6MROZGYH8KJsqL8YN4w352jrKwsLMWV39P7tKB9LnmEOCXW1irJuRDv7gPxz
	Tzza0hBp++IkWZfhm9N6GEcpZfDphjR5Nnn8kz7jBYT65CF8LYjNeuNsxWJZen6tcSQiv9xllFXMK
	wBGCYL2PhAqLN+wdkd2P/tjmfdCzTR8a0Ny9ul0VJZjYOtPisFIlPEwTC+BOWd0/ZjN7MsUpnUY6E
	oJd0ztYipFojc2OY6wXbiDm2evMdM99YVJkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	(envelope-from <johannes@sipsolutions.net>)
	id 1nrekz-00GK54-Jw
	for cocci@inria.fr;
	Thu, 19 May 2022 13:55:53 +0200
Message-ID: <9a0a9798f3be1950e11155a87d357442122e1685.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: cocci@inria.fr
Date: Thu, 19 May 2022 13:55:52 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] more precise switch/case matching
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 398
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/9a0a9798f3be1950e11155a87d357442122e1685.camel%40sipsolutions.net>

Hi,

So I'm trying to do something like this:

@@
expression E;
identifier OTHER =3D~ "NL80211_CHAN_WIDTH_(?!320)";
@@
switch (E) {
case OTHER:
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
case NL80211_CHAN_WIDTH_320:
+#endif
}


which I _wanted_ to add both the + lines only in case there was
something like

        switch (chandef->width) {
        case NL80211_CHAN_WIDTH_20_NOHT:
        case NL80211_CHAN_WIDTH_20:
        case NL80211_CHAN_WIDTH_40:
        case NL80211_CHAN_WIDTH_80:
        case NL80211_CHAN_WIDTH_80P80:
        case NL80211_CHAN_WIDTH_160:
        case NL80211_CHAN_WIDTH_320:
                break;

so what I wanted was=20

        switch (chandef->width) {
        case NL80211_CHAN_WIDTH_20_NOHT:
        case NL80211_CHAN_WIDTH_20:
        case NL80211_CHAN_WIDTH_40:
        case NL80211_CHAN_WIDTH_80:
        case NL80211_CHAN_WIDTH_80P80:
        case NL80211_CHAN_WIDTH_160:
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
        case NL80211_CHAN_WIDTH_320:
+#endif
                break;


but what I got was

        switch (chandef->width) {
        case NL80211_CHAN_WIDTH_20_NOHT:
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
        case NL80211_CHAN_WIDTH_20:
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
        case NL80211_CHAN_WIDTH_40:
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
        case NL80211_CHAN_WIDTH_80:
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
        case NL80211_CHAN_WIDTH_80P80:
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
        case NL80211_CHAN_WIDTH_160:
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
        case NL80211_CHAN_WIDTH_320:
+#endif
                break;


because it's apparently treating each case kind of separately.

Is there any way to not do that?


Similarly, I don't see a way to make something like this work:

@@
expression E, value;
@@
switch (E) {
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
case NL80211_CHAN_WIDTH_320:
...
(
 break;
|
 fallthrough;
|
 return;
|
 return value;
)
+#endif
}

it actually results in adding only the +#if line, never the +#endif
line, which is a bit surprising?

Is there any way to turn off some of the magic in switch/case handling
so this might work?

johannes
