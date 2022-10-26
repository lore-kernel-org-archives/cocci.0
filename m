Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038F9C38A2D
	for <cocci@archiver.kernel.org>; Wed, 26 Oct 2022 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=U68WKS/WXXdKZ+ys91Y2+mB7Nn8soPCfpfPf63g4ffc=;
  b=YRD6Rd1titMdvF0GhAKHMWjTmpG6oA8Rtv7wdBSPPEsvFwXGic2Wu8lx
   TIFd94OuNuxseESIXm6acZ6D7bkNCMu96hNjpYJYlsX5/SF77LABWs/cN
   xkQlTkZG7hnN0mtrBPyd5mS+1uwNo9+93JLAd6XJB6G3kIxmT82I85YU9
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,214,1661810400"; 
   d="scan'208";a="71631472"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2022 13:00:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9CB46E01CC; Wed, 26 Oct 2022 13:00:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E0C7AE01CB
	for <cocci@sympa.inria.fr>; Wed, 26 Oct 2022 13:00:19 +0200 (CEST)
IronPort-SDR: 63591343_7fBMkdo+GgfRWwGCGB1wce0/y7v4qEruwo7aMfHR6ca1fEE
 dcvIpTpGv+Oa/+FCY7hHIfg4c6mDqn3/IbL6dOg==
X-IPAS-Result: =?us-ascii?q?A0BbCwAfElljgE7ASNlaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?U8CgiuBAVYuBAtFhE6QcwEokmyKNIF8DwEDAQ0UAQElBgECBAEBghKCLkUCh?=
 =?us-ascii?q?HcCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBARgLF?=
 =?us-ascii?q?wcODgcihWgNgjUpAYNkAQICASMdAQERJgEPBQYaAiYCAlcGJIJsAYJsAQMNI?=
 =?us-ascii?q?wcMqxSBMoEBgggBAQaBQAGDDR8sIlOBXQMGgREsAYcmiEZ6JxCBVUSBSAGCR?=
 =?us-ascii?q?jA+gmIDgV+DV4Jmjw+DFYNaOANEHUADRjINUBwxJw4JHxwOFw0FBhIDIG4FQ?=
 =?us-ascii?q?Q8oL2crHBsHgQwqKBUDBAQDAgYTAyACDSkxFAQpEw8tByNxCQIDIWUFAwMEK?=
 =?us-ascii?q?CwDCUAHJSQ8B1g6AQQDAhAiPAYDCQMCIoFMMSYFAw0XJQgFTgQIOgIFBlMSA?=
 =?us-ascii?q?goRAxIPBiZHDko+ORYGJ0QBNA8OFgNil3iCEYE/AoJ3khGDKqwhNAeCHYFJg?=
 =?us-ascii?q?UsMg3uFc5USMwOWZQaSE5ckjUGVEgOFHoFiOoFIDAczGiSDNk4DGQ+SRYELg?=
 =?us-ascii?q?1aFTD80AgEIMAIGAQoBAQMJhUcBAYUSAQE?=
IronPort-PHdr: A9a23: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
 Fg6h1kmCdk=
IronPort-Data: A9a23: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
 OzyIkHNAyU=
IronPort-HdrOrdr: A9a23:uKLl+6wpJQbh4KL9rG6DKrPw3r1zdoMgy1knxilNoNJuEvBw8P
 re5MjztCWE6gr5PUtKpTnuAtjkfZqxz/BICKgqTNOftUzdyQ2VxeJZgbcKoQeOJ8SWzIc0uJ
 uIMZIOceEZyDNB/KHHCWKDYrUdKbe8kZyAuceb6WtxRgd3bKxa4x5+ERvzKDwIeOA8P+tCKH
 KGjPA32gZIlE5nEviTNz04f6zmq8fQnJzrJSMXHhJP0nj0sdsihYSRLySl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,214,1661810400"; 
   d="scan'208";a="71631468"
X-MGA-submission: =?us-ascii?q?MDExTSqLUodGt3RvjtcDeZHnONCrXlzrWKIsqm?=
 =?us-ascii?q?dCsFjheJcKPInVyte+9ZLmObR2sbaw7jSVGuXVOiV4duiOKmBq277gh0?=
 =?us-ascii?q?+z2soJrbdOF3NeLodgsHV/c4FWe2o7O6higy+Qitm6RGj7Xhi5VPuH1z?=
 =?us-ascii?q?DPSzPNOzjqGUqZKdcwL9aS3g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:00:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666782018; bh=U68WKS/WXXdKZ+ys91Y2+mB7Nn8soPCfpfPf63g4ffc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+Zg/zFw3wE+W+29RrojETclRJeXpUvhBGthzdxzwOuUIww8CWgafHWkNZtqpigtR
	 GLvQpOsMT/r8zw+ZfZS+Ob6QUUYCDn9Q9o3Jnsqnj91KJXAxDll+womlCmJu07f3pZ
	 I3BUA2bVC4/ejqK6Zj9QecYBNVWCCI/tR/kfFDnNSDHH1PCGfCIYDDjvqmoQsJD37z
	 1CwZW5pEgEAWemlky5yKDajOFck9r5Y7kjXjzxzCvR4s2EVkosOArg0qOuEogDjsXM
	 clSGNRzengFlHX+9MP1eFb3Y5wCRnVAuQbRxpQ96WV5F9r6aO9LtHyB/+f6mCWydtd
	 2eYL0rSNAgF8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.80.160] ([94.31.80.160]) by web-mail.web.de
 (3c-app-webde-bap53.server.lan [172.19.172.148]) (via HTTP); Wed, 26 Oct
 2022 13:00:17 +0200
MIME-Version: 1.0
Message-ID: <trinity-49d6a5a1-3e1e-4377-930c-0d391bcf0ae1-1666782017848@3c-app-webde-bap53>
From: Markus Elfring <Markus.Elfring@web.de>
To: Thierry Martinez <Thierry.Martinez@inria.fr>
Cc: Jan Tojnar <jtojnar@gmail.com>, Julia Lawall <julia.lawall@inria.fr>,
 cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Oct 2022 13:00:17 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <ow4zgdj3t7l.fsf@inria.fr>
References: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>
 <3ee3239d-4b72-9239-893e-b08acbae7df9@inria.fr>
 <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
 <ow4zgdj3t7l.fsf@inria.fr>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:UX7QeMQLdHtfwBfWk1a/BIetmtDKukdZwzjaOcvHqK2PenoOIbe9GrgRKkETfje9pAfo2
 drm3G0pGiiJygY9FmM1RRs3524wXUWuMHepPkcwHaOG2HhZyMFzjW3VFHXEPSVQ6yqd21euHJ1FO
 K8uwDpsUHB4l8fau9NPWRbOwV9W/AvrNog7KEdMihiVTqnIXb+Um7LIPzbw5Hj8OzvM9YJo/L3QJ
 fpt8FB2pKqQWjiBwnKJqKPtfaHk7GN+j/vur090g2K3ag37QR8ncl1pVdjIn6mPWOO28QnRkmLS0
 WQ=
UI-OutboundReport: notjunk:1;M01:P0:Q5Quz0ReE5Q=;uFjY10JB4YX5h5UZkWFL6kzlwBw
 g/XxPTPVzpjrYhyConWbOLpe/lDQlih6NjQLVzxd790zJU5h/GHyarLDzFfS41ZR05P+BEhwF
 qZ4MrK86O0AT0fadPVyb3HBn3dJyLYND+MIvhXG64lOkiU804IveI2+aFOUPwCRZzjh+Fwj7e
 js5nAPRWXpcV/s4p+oqPxy3PVjJzu2WDyXgGih8LE7q517kPZy2/MnclWknBfs1xEAXVg+YKU
 yF6hPSYWHBz7UCp00phLtJ9p3wuHyBeTce9y1H+/MEZiULn4olQMzejyLqSk/x+3Tp08QUxcB
 LTMumYRNluYUhjUQrDcN5mY9UryoRYJJ3nHbKIdH9QM4N65KKir0jKCXTav7t2NKOZymXmOZZ
 pKvmvFaF2SL6pOIsIRfykRYYDlMHM8ow3Vn+ZLrZ53PvIxSiRycEiZLwzPib7zIkc/RhDK/oA
 QkhHaemFOSKju5rv/jva5dmAuODTZyiy23uhfZY1RAZ107aNic7vDnDDM84PJkE1g8ugPMt//
 UYBsN/mKdQXbardcahwPROkKMsdWzJf80mnj2TOPQTah6ePZ8ylJ9jef8eOmKemtiN8VHn7er
 8EFrZZiKF1gTde2IVqJ9gjN2THE7LF8F40yhqeLt+qJvRAN46aQFjv0VLJOKnDiaI86nTMxPu
 H5Aoz2jLVekhf8Q+ZC5FK08kTLVQKkJZJv0Yf3t1BBBgm9xl+B0zmYUEXVVSLvAVmJu/8UR1C
 yJCx0c5n07O4aKSQEFijreJbr7/TLkiLpHC8zgBGfP3x5sPR9+kAOY9d6yZTIXL69/J3Bh8YY
 MuM+mbCqatYSqGEA2Ip0cFfvOoqRdUyE7p8VmSQHUY5eU=
Subject: Re: [cocci] No longer possible to build with system dependencies?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 692
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-49d6a5a1-3e1e-4377-930c-0d391bcf0ae1-1666782017848%403c-app-webde-bap53>

> > Apparently, three braces are sufficient to make it work but why that is
> > the case eludes me=2E m4 language is simply beyond my comprehension=2E
>=20
> Oops, you are correct: [[=2E=2E]] is the proper way for quoting strings =
if we
> want to preserve inner square brackets
> (cf=2E https://www=2Egnu=2Eorg/software/autoconf/manual/autoconf-2=2E69/=
html_node/Quotation-and-Nested-Macros=2Ehtml)=2E
>=20
> It will be fixed by the following merge request:
> https://gitlab=2Einria=2Efr/coccinelle/coccinelle/-/merge_requests/231

I suggest to fix further details=2E
https://gitlab=2Einria=2Efr/coccinelle/coccinelle/-/commit/0f96f7b8ac3f6a3=
1f571eb845e6c253a34f935b6

1=2E Improve the proposed commit subject =E2=80=9CFix quoting for configur=
e_test=2Eml=E2=80=9D=2E

2=2E Add a helpful commit description=2E

Regards,
Markus
