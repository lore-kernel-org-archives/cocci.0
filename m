Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0E2C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=W9/3AAz/5bROj/TgrVFTCsZS6KALSg7+OsNn3VeUH4s=;
  b=DNifsFHXqVqaoEOgU7OMWBU/4Ce3Ia+FfD2AavYJWZ5AjhO02sFHzZBq
   jr2nXQw+2M1FGH+kjTl+DDddmWGiJbDTPiffr0XqcpiaJfPbWGl7F58GR
   OwNV6/WEEYhrl/cmqwNK3GtEYtkixNPwkx7PC4aABFKlXJ6ZblQmTdfzj
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25870687"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 18:34:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D4E7EE0048; Sun, 13 Mar 2022 18:34:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4A37FE0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 18:34:30 +0100 (CET)
IronPort-SDR: EsW6EsGqKOC81bvDXrbB6VNfjc1WLhITldCn3CIue/EfKElNTaOcs6J9LfNGBTyil6RObBxX+e
 FNILImCQL3X16zdIZDUQs2YkRMmG/HiAoH6WqXsbHqq9PB3m6iXAAEeYtUT/WZmBUkJVcR7CwH
 Yi0QOTPoKflXZUrJK3gcjsuPzK23KmVJ+r8dvhEvfT6Ng0DuTDFrwql9Ts+17sPmWFmI1DCqdl
 NEJ9tHsX0Ove27k0xzKBRTTX0EH9fPYAHFHdAkM91mJkOzE0JC77iYWuRLisyzynQqjxFqNFcI
 kDdxx6/eumz8rDZ7qfds511L
X-IPAS-Result: =?us-ascii?q?A0DpAQCIKi5igAMP49RaHgEBCxIMQIQCgVUrBAtEhFSQa?=
 =?us-ascii?q?jGLI4cWjCILAQMBDT4BAgQBAYUHAoQkAh0HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgMEARMBAQ0NCQUICgcODgc2Bl4GZASBSwSBdAs0DYI1K?=
 =?us-ascii?q?QGDZAECAgEjHQEBESYBDwsaAiYCAkwLBg0IAQGDAIJlAQMNJa4+gTGBAYIIA?=
 =?us-ascii?q?QEGhEgfLCJSgVsJgRAsihODO3onEIFVRIE8gwM+hEWDGoJlmBrDEzQHghKBO?=
 =?us-ascii?q?oFAC54LBhQug2GSWQ4GkWkthSWRBaZ7NYFDgX4zGiSDOE4BAgECDQECAgMBA?=
 =?us-ascii?q?gECCQEBAo4dhCWKLEA0OAIGAQoBAQMJAYFWg3ABAY0cAQE?=
IronPort-PHdr: A9a23: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
 j3ni6/5bjtPoYq8wA==
IronPort-Data: A9a23:L0pz7qCj0zfYoBVW/znlw5YqxClBgxIJ4kV8jS/XYbTApDMh0WZUz
 GJJCDiOPveIYDP3Ktgla9i1pBgF7ZCBmIM2OVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPgWFvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYozqZkY5S5
 94ciaKXbCsOMbDUtMkxEAYNRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWDwIr
 pT0KxhVBvyHr8e/2rGmUa9Bgso5Lc/kFJwSsDdswFk1CN58HMCcG/uaube02h88hP5cG/Hdb
 PYkcDxCNwjMRTxUBmsuXcdWcOCA3ySjLWQB9jp5v5Ef6G/Yxw1Zy6noKNOTe9qQRMwTkFzwj
 mbP4G39BjkINdmV0zPD83S2h+aJkzmTZW4JPLi/6+Isn1CZgGAeYPELabelifaphBCddNkOF
 3Iz3wYJorUq2GGHDcaoCnVUv0W4lhIbXtNRFcgz5weM1rfY7m6lO4QUctJSQIF+6JRsGVTGw
 nfWz4q5X1SDpZXIESr1y1uCkd+lEQQ4RYPoTQoDSxcM6dD+uunfZTqSEIo6SMZZYvXPGTzxx
 TSDqiR7v7saidxj6klW1VXAni7quZXDCAI4juk2Yo5HxlMnDGJGT9X2gbQ+0RqmBNjAJrVml
 CZd8/VyFMhUUfmweNWlGY3h5o2B6fefKyH7ilVyBZQn/DnF0yf9Id8JuWokeRw4bpZsldrVj
 Kn75lM5CHh7YyrCUEOLS9nuYyjX5fW8RIq+DJg4kPIUPsgsK2drAx2ClWbJgjyzyRFy+U3OE
 c7VKI6tC2oXE6Jq0HK/SI8gPUwDlkgDKZfobcmjlXyPiOLADFbMEOttGAbQMogRsf3VyC2Io
 o43H5bbkH13DbyuCgGJqtR7BQ5RfRAG6WXe8Zw/mhireVU3RwnMypb5ndscRmCSt/8Mx7mSo
 S3lBBMwJZiWrSSvFDhmo0tLMNvHNauTZ1piVcD1FVr3iXUlf6i166ITK8k+cbU9qr58wPQyQ
 /RcI5eMBfFGSzLm/TUBbMCh/dI4K0nx3VqDb3i/fTwyX598XAiXqNXqSQvY8nVcBCSAs8Zj8
 aar0RnWQMZYSgk7VJTWZfujwkmfp38YnO4uDULELsMNKlrh+s5mJnWp3PMwJsgNLzTFxyebj
 lrHX01H+LOV+4JsqYvHn6GJqYutAtBSJEsCEjmJ96uyOAnb4nGnn91KXtGISjaBBmn6z6OvO
 LdOxPbmPfxbx1tHvtYuE7tvyq5itdLjq6UDl1ZhG2jXKUumAPVsLyDej8VIs6RMwJ5fuBe3A
 x7epIMFZO/RYM61QkQMIAcFb/iY0a9GkDfl7cMzfBfw6hhx8efVSk5VJRSN1HdQIecnKo8j2
 ut96sca5xbm00gvNcuayD9Z/SKAIyVYAakgs5gbBq7tixYqkw0TP8aDV3WuuJzfOc9RNkQKI
 yOPgPSQjbprxn3ELyg5G0/L0LcPnp8Joh1LkAQPKlnhdgApXRPrMMC9MAjbTzi5Cj1C1P9vf
 HdmPQt5KM1iOtuuaNdrBwiR98NpXXV1OXAdD3MWmWefQ0TAuqnlMjgmIejUlKwG2zs0Q9WYl
 Y10DE76XDyscMyZMu7en6J6g6SLcOGdPTEuVCxq8wpp0nX6jffYbneSWFc1
IronPort-HdrOrdr: A9a23:rVp9Vql8Yie2wuhjAddFHu2H1n3pDfII3DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25870684"
X-MGA-submission: =?us-ascii?q?MDHCrl/jLgZIEUuB3fcutig+/1vGEQqYLgFNlg?=
 =?us-ascii?q?cycJ3TzsyV2uxA5gHS/HlOj+UJ65CCAC9prFDNIuJt3yS+E+HYLzH5X2?=
 =?us-ascii?q?RvcTYvQIv6DTFURgBjN0yReHNSde4Bzv3lv+fy/iBBzndpSnfpdQq+35?=
 =?us-ascii?q?5CwlcfgZ/gE8p6O3oSMy/bJA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 18:34:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647192869;
	bh=Ww3E+zqR2+cND933ecqZLRqsc/EB7faLTYoEcIuK2FI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GFlT36zWyJrqhj0vvmUG1B/up2jcv58nJmdCxPGa4KikLQhKrNWNDbsdDz8jlzlVL
	 42duTTGOTTdrDVyKie5qT7PhZCfdB5LLpq+2oS3gtknG7fh82WNwuMaSks/eH2I12b
	 yShBfSlko6PwSxDFIp1+ydtz5f7c0AnPQ9OPFu28=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.179.181]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1nJWTZ0Qui-00AOEN; Sun, 13
 Mar 2022 18:34:29 +0100
Message-ID: <f208cc12-e514-7ae5-f7af-a053acc10a79@web.de>
Date: Sun, 13 Mar 2022 18:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
References: <818d2b72-e28a-ba5e-661c-cba9fe9914ca@web.de>
 <70ad3def-a4f-14b4-cb70-acfe4a516d9b@ewheeler.net>
 <c415341b-70c4-2bc7-b067-39c273ace958@web.de>
 <alpine.DEB.2.22.394.2203131821210.18925@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203131821210.18925@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SWG4ZbKn3KKXujrMgYqQ8SDxJYg5Rk4yxR6tofXAF9sGk62WSl8
 MIL4YIA0SejBntm5VKLjaMx8EKuLuUpRW5sh4PnWGyis/kD4yUfQznHLFj7sjGlparx/RJO
 qZ56emsnLAdmLkZy5j8ClWZ41ZoB2kGt7mWjg2ryopvKP3GwLYwcTbDv+wAyr6Kmn3ieGFD
 PgS3puzrS6e1JmEN+Ch3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:thRxfuwNsgs=:cgLHXFi73Mxn80O1BtZUef
 gZzyRjbJcGlF9e+3eHcs1y73cv+SohT+h3UjpNq6KM/C3y7VtWrlXdTB0v8rosrwFCrXMqzAM
 9PGtwdLr+kYZ/o/6cZPcjNo1MMeMv0J6bVdftik+1fAnK/OgOXbUFMSXQqbXuB04YvppuSzHe
 wRGsTOwJwS3YNtlnjMrtxU5q2RLhlogT+Fg4zBzdjn+vrknolkd82kNpfZ1jigOr4pUODgAdi
 /jYomllKcTUMikJfgaDfxjpVCGEVVUJaHIkXpp/Mmvt7KmM6SrL11WhgedL+wZjKfzFYMEQ9B
 uYhhfl0G1dnUchF9FURi6tz21/zsnOJXGSSkXTSa0928ERRcMX7exhYsVJcWZSOCqGaIUSlWn
 EzhEn1xkSwHOzR7GbIpouNom2nG9GzggmfEJ+AYoiS/+8x7/feRWZDxdDYjrHiQWj0wFrZJ9r
 NpnNqKm2KmsImNKd1tlffuCPqBnuz68RzCaYmgpoQ5ff3KILyDPBFI+QS1ZRA0iHVRiTCsHpc
 VxpO7fIVVHnT5mbwo5YQhbCiBKs+A/98qZM3VCtIYtoRUTdTGpZnpi1O15Xi0TX1r8EMS0DIR
 KPfBHK+BcHVclZDFiSW/DNwhUwEB8pZPJi268b2jNpEJWNQXoP5xnvLrBvV8NsZ6Jzf9nJ5KA
 GqjYDS4YQ57C2r4TBv8YegSSo9Ku2ReohAKS7BpH8OF0LClyWqqoXu1C+g2ngMe+EmiteDhh4
 9lFuhXII3YFDgRFsVt1EJj+UKLiWO+4kuE8uYUgK8tFE+gFuI3ruvSaE2oEL+ALYbun5GY+1t
 Ah3OZ7RYxYsyI/+GRHo//Y1dwPjCTSFnu/0Re50d9HMFFMk3VPbf1Yg8rGuL1p8kvkik0JS+u
 j+vdoziwhws+jIRIci1z4qkwuz40lt3Be8/tw78QN+GpHV/zmB+/MijulIf2wQOn1Iy5MZlMH
 z0XWsPZt3xrz2SdENy90qiBfWRpb06eqbT9C60fnsPQxAUdLm2OQLtmtPCb5qP4aScXhHIISj
 cson2qV3jvqzkTNe8TlXoXKhy+N10SQrrW/ZQStEdDKj4d+MtELR98VWeGoZiPxUIj2rrG3ji
 331O74Ozs57NW4=
Subject: Re: [cocci] Checking the isomorphism =?UTF-8?Q?=E2=80=9Cptr=5Fto?=
 =?UTF-8?Q?=5Farray=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 224
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/f208cc12-e514-7ae5-f7af-a053acc10a79%40web.de>

>> Thus I propose to delete the specification =E2=80=9Cptr_to_array=E2=80=
=9D from the file =E2=80=9Cstandard.iso=E2=80=9D
>> so that only safe source code searches and adjustments will be performe=
d.
> Te idea of an isomorphism is that one may related X and Y if transformin=
g
> one means that one would likely want to transform the other too.  It
> doesn't mean that X and Y are semantically equivalent.


I got an other understanding for the term =E2=80=9Cisomorphism=E2=80=9D.

Are there any variations to clarify for involved meanings?

Regards,
Markus

