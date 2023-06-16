Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D54EB64D7
	for <cocci@archiver.kernel.org>; Fri, 16 Jun 2023 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4dTJfKE7N41utwTSfFybG1xUAYZFI8tPcdVXikrznMc=;
  b=ZX6duHJ07/3Xrub6zsiM6GgxzfVC+7XQ0orfl+SSsK5VsqCRJ8sThEHw
   AKGsV366xpdyY0S34RzLksBzbQwViit1BD/V8BmKYXnTkW1Mi5MloGFSh
   p2UAujZb5ucUQRFsgdb29Ejab8Qw+gN14xsyvKBaUfwwxbT6ucJIcCoNW
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="113198132"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2023 11:38:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DD2AAE03AE; Fri, 16 Jun 2023 11:38:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1C746E0157
	for <cocci@sympa.inria.fr>; Fri, 16 Jun 2023 11:15:56 +0200 (CEST)
IronPort-SDR: 648c2849_mwxGqPBFfWvF9cRmOtLut2ohgEtWKI2EpLHypR7szApzAd8
 uGT4JNvyZh3Ujpsb5I4lCZfCaFcFbJxsMoDPmXg==
X-IPAS-Result: =?us-ascii?q?A0E0EgBKJ4xk/z4rTJBaHAEBASsLBgEBBAQBAQIBAQcBA?=
 =?us-ascii?q?RWBTwKCLXpQEB4DBwhHhFKIfKZHgX4PAQMBDRQTGgECBAEBAwSKfx8GAQQxC?=
 =?us-ascii?q?A4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNgjcifYEIA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBARYCCF5JHQEBODQCJgKGTQOxDoEygQGCCAEBB?=
 =?us-ascii?q?oJmmmqBXwmBFS0BiTmIaIINig+DDoJnji2QCWWBKG+BHoEifwIJAhFBJoEIC?=
 =?us-ascii?q?F+BcUACDVQLC2OBHIJUAgIRPBQFPBF5HQMHA4EFEC8HBDIoBgkYLyUGUQctJ?=
 =?us-ascii?q?AkTFUEEg1gKgQ0/FQ4RglpjPxtUgTc3AxkrHUADC209NRQfSoIAgXcKSKM2U?=
 =?us-ascii?q?UwCgVKBA8QKhBKBXZ9wgUqVWpIzmBeoN4FlATorgS4zGggmCoMiTwMZD5Zti?=
 =?us-ascii?q?yJCMTsCBwsBAQMJhUQBhgMBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:rVnesa/5/Y0NRdtMlpOiDrUD/XqTJUtcMsCJ2f8bNWPcYEJGY0x3n
 GYYWWuEafnYYDT0fo91PoSx9kpV7ZKGztY3HQM//ChEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWYsWo4ow/jb8kg34q2s4GlwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TEnPI0VFhqY7QiptlsEG9Q0
 9wFK3MKV0XW7w626OrTpuhEncU7N87vIZ8evXd7izfUEZ7KQ7iaH/mMuoEegGx22Jom8fX2P
 6L1bRJtaxTJZRtCIX8MCYolm+O1mnj4dSYerl+JzUYyyzGKl1UgiOiwa7I5fPSNGutfwEaD+
 1vZxF30OwMravOnkgqapyfEaujnxn+rBtJLStVU7MVCi1qYzW07EwwTTVL9oP+ji0f4Vcg3F
 qAP0jF167Mz7FesSsThXhq+uziCswJ0t8ds//MStwbXkrOIvT+jWlcfXzBfTvw7t4wxfGl/v
 rOWpO/BCTtqubyTbHuS8LaIsD+/URT5y0dSP0foqiNVu7HeTJEPYgHnE485Qf/u5jHhMWCsk
 mnSxMQrr+9L1aY2O7OHEUfvrx/Em3QkZhVuoB7WRnmi6h5lZYmjfMqu5ESzARd8wGSxEgDpU
 JsswZH2AAUy4XalzXPlfQn1NOv1j8tpyRWF6bOvdrF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RGD51MMvsQMYiv7NMebhr5d7ex6l8AM8vy1DpjpgiZmP8AZmPKvpns+Ox7LhQgBbmB8zvpmY
 /93jvpA/V5BVfQ5nGPoLwvs+b8m2jI4yHmbQpb/zhKquYdyl1bFIYro8TKmMIgE0U9ziFyKr
 IkBbJHRkk03vS+XSnC/zLP/5GsidRATba0aYeQNHgJaClo2QjMSGLXKzKk/eodoua1Qm62at
 ju+Q0JUgh63z3HONQzAODgpZaLNTKRPiysxHRUtGlK0hFklQ4Kkt5kEe7UNILIIye1EzNxPd
 ccjRfmuOPp1d2n4y2wvVqWl9I1GXza3tD2KJBugMWQefYY/Zgnn+e3EXwrI9QscBxqdp8Fks
 +Ss+QfFS5wmWg5nMp73ae2u/Xy1r3MyiOJ/ZGqWA9hxKWHH0plmFDz1tdAze/ozEBTkwiCL8
 QS8DTMzh/j/k6Vs/Pbn3am7/pqUSc1gFU9kLkznxLeRNxiC2FG8wIVFAd26TRqEWEzaoKydN
 PholdfiO/g6nXFPgYp2M5Bv6Ykcv9LPhbtr/j5ILUXxTWaAK+1feyGd/Mx1qKdy6KdTulK2V
 mKx69BqA+i1F/2/ImEBBjgOT7ql5akPlyjw/MYFBhzwxBVK8YqtVWRQOBixixJhEoZlDbN9w
 ckdlZ4XzyedlisVNs23i3EI1maUcV0FfaYVlrAbJ47JmAMb4ENIO4yFBgDy/puJTshGN3dyA
 z6LhZjtg6ZX6VrCfkESS1nM/7t5rrYftC9ayGQtIwyypePEofsszTtT2zgTZSZE/CVtiu5cF
 DBiCBxoGP+o4TxtuvlmY0mtPANwXDui5U37zgoypl3zFkWHeDTEEzwgBLyr4ksczmN7ewpb9
 pG+zELOc27jXOP17xsIdX9Vkd7RZv0vyVSag+GiJdqPILciazm8gqOOW3sBmyG6PewP3n/4t
 ctY18cuT52jLiMBgbwJO6/D35QqdR20DmhjQ/ZgwaA3IV/haAyCgTijFkTgVf5Odtrr8FC5A
 fNAPshgdQqz/wfQoyE5BZwjGa5Vnvko74AGZbixdHUKg4GHpGA0orbVqyzyr04wYtBUic1mA
 JjgRzGDNW2xhHVvhG7GqvdfCFe4edUpYA7d3vi/1ec4CKI4r+BndH8t3ouOv3m6NBVt+zSWt
 ljhY5D64vNDy4M2uafRCYRGWhuJLO3sWNSy8Ayct8pEafXNO5zssyIXslzWABRED4AOWthYl
 aW/j/Cv5Rnr5I0JamH+n4WNM4Jr5s/oBepeDZ/RHUlgxCCHXJfh3gsH92WGMqd2qdJ65Pf2d
 zvgPYH0PZQQVsxGzXJYVzlGHlxPQ+7rZ6PnvmWmo+7KFhEZ1hfdIci68WPyK1tWbTIMJ4a0H
 zqcVyxCPTyEhN8k6N446/Ba71tQO177QqwiasHwsj+DSG+lnjtuf5P8wAE452ij5masSa7HD
 VDtH3AStyhefInTzclCtIhvohwQCm07h+QsFq7Y08AjkCi0VQbqMsxEWajryfhofujaz5Dgf
 zbJcXcjDiPmGzJJbX0QJTglshi3XoQzBzsyGtDlE454pct76ENszYaNLhtd3ko=
IronPort-HdrOrdr: A9a23:5fmkbqAAgSCWH/TlHegmsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U4ssQIb6Ku90ci7MDvhHPtOjbX5Uo3SODUO1FHIEGgm1/qa/9SCIVy0ygc+79
 YGT0EWMrSZYjZHZITBkW+F+r0bsbq6GdWT9ILjJgBWPGNXgs9bjztRO0K+KAlbVQNGDZ02GN
 63/cxcvQetfnwRc4CSGmQFd/KrnayHqLvWJTo9QzI34giHij2lrJTgFQKD4xsYWzRThZ8/7G
 n+lRDj7KnLiYD29vac7R6d031loqqh9jJxPr3NtiHTEESutu+cXvUuZ1RFhkF2nAjg0idurD
 CGmWZbAy060QKtQojym2qm5+Co6kdQ15fvpGXo/UfLsIj3Qik3BNFGgp8cehzF61A4tNU5y6
 5T2XmF3qAnei8osR6NkuQgbSsa4nacsD4ni6oennZfWYwRZPtYqpEe5lpcFNMFEDjh4I4qHe
 FyBIWEjcwmOG+yfjTcpC1i0dasVnM8ElOPRVUDoNWc13xTkGpix0UVycQDljML9Y47SZND++
 PYW54Y4o1mX4sTd+ZwFe0BScy4BijERg/NKnubJRD9GKQOKxv22uzKCXUOlZKXkbAzvesPcc
 76IS1lXEYJCjPTNfE=
X-Talos-CUID: =?us-ascii?q?9a23=3AqG0bs2sSbRmrAsfx8uKWGc4b6It6dSeF1SuOGnX?=
 =?us-ascii?q?kNn14RqOzaUKTu6Rdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ai0u2rgzmbgqj1DvTWj1KoIGA7SSaqKPxJkpTkY5?=
 =?us-ascii?q?bgta/DCFJKQbDowzscpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="113190853"
X-MGA-submission: =?us-ascii?q?MDEid/l7O0QLZqvEfZhOoX9mPfkIvPXBN0Pp0v?=
 =?us-ascii?q?nxT8gFZkTQkqEmd2tyXV/WQ1Q3TIV2k6F5El/PIZdPH+BNz+9ayoZQhy?=
 =?us-ascii?q?5TdxoPc5zB8eqVoUhu3cLETnjM62a77oSzLTSe/nu5KEXMK3Yug27ARU?=
 =?us-ascii?q?Wz/rha6uPGOS+GGfQD3LRzVg=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([144.76.43.62])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:15:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=4dTJfKE7N41utwTSfFybG1xUAYZFI8tPcdVXikrznMc=; t=1686906955; x=1688116555; 
	b=kYOdaoDVYg5etJUvjslrIpUVr1E3fPVxzT+ttB5wvpUh5B38jAL6Z8NQ3hR3sHHPNp9HrOPuwKq
	/iAc5Akh9Nx0hsKc8A2qGrA+NMUq+Zff1JjizGo5f78ArXkctklAxxHV6oRypZfqlkuM7KXHUrl/W
	L4oWNuEOSpOyl2udw/qag3Pj32FWz7EcVOUCInrnaAOWco7cRjIBDhMExBBTnPJ87qaonzcEUwRSL
	PZ+0k6Je2JYHv+Xdlysl9bV01SYPQAYyaR47uX4Z29/OPoBif1xxyC1KIzMpN9oW1JKFxwxnGaWXG
	yvVQDbpTQ5yRAyA+nfYUiBHLB0lcGF8KzCBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qA5Yh-008Hvu-0K
	for cocci@inria.fr;
	Fri, 16 Jun 2023 11:15:55 +0200
Message-ID: <a02bbe916c864ebaf407426dda76af34d1bdda6f.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: cocci@inria.fr
Date: Fri, 16 Jun 2023 11:15:54 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] macro parsing issue?
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 1183
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/a02bbe916c864ebaf407426dda76af34d1bdda6f.camel%40sipsolutions.net>

Hi,

So I was trying to do something (related to locking, changes in Linux
net/mac80211/debugfs_sta.c, in sta_agg_status_write), but it looks like
spatch doesn't parse the entire file correctly?


Here's a simplified test that should work on the current upstream
version:

@test@
identifier fn =3D~ "sta_agg_status_write";
type t;
@@
t fn(...)
{
...
}

@@
identifier test.fn;
type test.t;
expression pos, exp;
identifier ret;
@@
t fn(...)
{
...
(
+#if SOMETHING
        ret =3D strsep(pos, exp);
+#endif
)
...
}


It does nothing, but seems like it should? It ends up skipping that
entire function, I think, because of parsing issues with the STA_FILE()
or STA_OPS_RW() macros?


I've patched it regularly for now, which is fine too. So this is more
FYI.

johannes
