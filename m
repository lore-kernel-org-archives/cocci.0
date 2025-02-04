Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E921C02196
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z98A233FeCDkMDGKQ/s3CWRLEcEuU/sMmd8j+tLeLOk=;
  b=CMszdcvpWe6qq7dDxztJ7SAA4tPGmvBnUPWHfoFa3mSDr6B5biGBz3Ql
   owZsQ+Lu5avvVXT4yYzr0jTCVYInUh3arVScwUH5t50VS9SQnPU71L1bo
   OJwP5fa9TwnD5dgPYedLoBAAZYNxR28dDmO2E3aWJ4S99oVP7jGcieVA1
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206557297"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 16:10:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 50588E0D1F; Tue,  4 Feb 2025 16:10:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 89FA5E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 16:10:21 +0100 (CET)
IronPort-SDR: 67a22ddc_UjqrHpAqWQHUFejluM8I+WcJcSUn7uHBp3Ry8NdVqKZbMEr
 BNLtNFQc9fOKuzzergY4cBjHLXaH1tyfK4kj7CA==
X-IPAS-Result: =?us-ascii?q?A0HAAwApLaJng07ASNlaHQEBAQEJARIBBQUBQIFTgkRiG?=
 =?us-ascii?q?1ozBAtIhFaPT4F0hGuPEIh1g1QPAQMBDTkIAQIEAQEDBIQ6RgKKfQIeBwEEN?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAToHDjuFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkQCAQMjHQEBESYBDwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ+AYIvAQMxBw2xTYEygQGCDAEBBtpbHywiV4FlAwaBGi6Fa4JjA?=
 =?us-ascii?q?YVqATuEPCcPgVVEgRUnC4JHMT6CYQKBYINbgmmCM4RKZ6JoUnscA1ksAVUTF?=
 =?us-ascii?q?wsHBYEpEDgDKjYxI4EmBTUKNzqCDWlJOgINAjWCHiRYgitrBAWBLYI7hENfL?=
 =?us-ascii?q?wMDAwODNIJGVIJEghJ0awMDFhABgyV6HINIHUACAQttPTcGAwsbBj2eOD2FS?=
 =?us-ascii?q?gkZgibGDzQHgjiBZoFjDIoplTMGEy+DcZNTDgaSe5h8Io1imyqBfiOBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44hGYNhM8gjQjU8AgcBCgEBAwmFRgEBimuBSwEB?=
IronPort-PHdr: A9a23:3QgyKxSyAvH68yoB2itIf+3PQ9psotCWAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSB8ODs7ke07qK++C4ACpcus/H6ChDOLV3FDY7yuwu3DYcSPafDkP6KPO4JwcbJ
 +9lEGFfwnegLEJOE9z/bVCB6le77DoVBwmtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJ
 xmqsAndrMYbjIV8Jqor1hfFvnREd/pKyW5rKl+YghLw6tut8JJ5/Cldte8t+9RcXanmeqgzU
 KBVAikhP20p68LnsgXOQxGI6nUATGsdjwBGAxLC7BH0X5fxtjX1u+9g0ySEPsP4UK45Vy264
 6hkVBHnhiEHNyUk8G7Mkcx/kLhboBO6qBNhxYPffZyYO+B/fqPZetMaWHZBU8NMXCFPHo+wc
 40CBPcaMO1Gs4fyuUcBrRqmBQmtGuzvzCNIhmTr1qE+yugtDB3K0BAlE98IrX/arsj6NL0KX
 O62wqfHwjvMYe5I1zfz9oXGchIuru2DU79rbcrR0FMiGx/ZglmOq4HoOS6e2OQXs2ic6uptT
 eWhhHQ9qwFyvziv3donhIbNhoIb0FDE9CN5wIkoLtC/T0B0e8SkEJhNtyGBLYd4TcciQ29yu
 CY7zL0GtoW2fSYUx5s83RLQduKIfpGO7xn+W+mfPS12i2h5eLKjmRmy606gx/XzWMS0zltHr
 TdJn8fRu30DyRHe5MeKR+dz8EqvxTuDygTe5v1HLE01iKbWNpAsz7E/mJcPtUnOHjL7lUT5g
 qKYcEgv5+am6+PiYrr8p5+cMZd5ig7/MqQymsy/HP83PhISUGic/OSx0qDo807hQLhSkPE6j
 6vUvIrYKMgFvKK1HgtY3pg55xu9DDqqyNAVkHYdIF9LZR6LlYzkNl/ULPzlDPqyhUmnnSlvx
 /DbJb3hHovCLmLenrfgfLdy9VZRxBY1wNtC/ZxbEKsBL+j2WkLptNzXEBs5MwuszubiD9V9y
 58eVXiBA6CHK6zeq0KH6fw3L+mNYo8apir9JuA76/Lzj3I1g10Qcbez0ZcKbH20AO5qLkeab
 Hb0h9cOC2YKvg4wTOzwj12CVCZeaXGoUKIm5TE7FZmmAZ3MSICpjryBxia7HptZZm1dBFGDD
 2zne5+ZVPgScC6SJNRunSQeVbe9U48hyQ2utAjixrdpNubU4DEXtYr/1Nhp4O3ejQ099TtoA
 MuB0mGAVHp0n2MNRz8uxq9zu019ylGZ0ah5mfNUD9JT5+lRXgcgKZHc1/B6C8z1Wg/ZYNeJR
 0ypQtC9DjEwUN0x2cQDYkd8G9WnlR/DxTClD6UUl7yNHpw087jT02L/J8Zn03rGzrUuj0E6Q
 stTMm2rnqp/+BLdBoHTl0WZk72ndKUd3C7I72iD13CBsFtZUA52S6XFXGoQalHYrdTjtQv+S
 OqQCL87NREJ5seHIKpHcJW9k1RNWPD5ftvXZmiwln2YBBCSx7rKYpC8Py0/wSHcAQAgmh8a+
 XLOYQojAiao5WbXEzVqEXruZVnt+K9wsiX/BkQzxAqLR0xnzbu8vBAP1tKGTPZG+7seuzo64
 xhwEky82d2eX/+JvQl8Z+NxZd0n4VFI/X3UvUpxM8rzfOhZmlcCflEv7AvV3BJtB9AFyJByx
 JtL5A97KKbDlUhEayvdxpfofLveNmj1+hmrLa/QwFDXltiMqe8U8PptjVLlsUmyE1Y6tW192
 oxw2mGf+46MIQ4cS5P3XW4o+hI8q7yJKjIl6dbs3GZ3ebKxrieE3tsoAOU/zRP1Wt5FM76fU
 iL2HdcbAceGN+Eg3VSkPVofJO4H0qkyMou9cueenq6mOOE1hDW9kWFO+5xwyGqJ8DdgDPHF1
 dAJzpl0xyOhUDHxxBeku8HzwsVfYC0KW3G40W7iDZJQYat7ecAKD32vKou53Ic2gZmlQHNe+
 FO5YjFOkMa0ZRqfaUD81gxMxAwWp3Kggy6x0z1zlXkgsKOe2CXEx+mqegAAPyZHQ2xrjFGkJ
 obR7ZhSeUGybBUy0jah61z7wadzu6l1aWXeAA9JcyXwM2B+Q/6orLPRK8VL6Z4urWBWSLHmO
 A/cFeS7+kpAlXyzTA48jHghejqnu4v0hUl/gWOZdzNoqWbBPNp33VHZ7cDdQvhY2nwHQjN5g
 H/ZHAvZXZHh8NOKmpPEqu37WXimU8gZVCDxzp6b8ga/63drBxKXgP253NHqW1tfs2ezx5xxW
 CPEoQypKKzizaenKqRKekdyBVnzw9V3EMdyn8Fj4fNYkWhfjZKT830dlG71OtgOwqPyYk0GQ
 jsTysLU6gzosKF6BkqA3JmxFnCUw886IsK/fntTwSUlqcZDFKaT6rVA2ypzuFux6wzLM7Bxm
 TIUyP1m73B/4alBnQM3zTiGRJ0WE1NZOyPEiBmCqdyz5Klaf2egd7Gs2VE2x4n+Su7Y5FgNA
 jCmKt8rBmdo4996MU7Q3XGWiMmsY9TWYd8J91WVnxrGk+lJOcc0n/sOizBgPDG1tnkkxugny
 B12iMvj487YcSM0rfj/XU4LU1+9L9ke8Tzsk6tEy8Of3oT0W45kBi1OR5zwC/ShDDMVs/3jc
 QeICjw17HmBSt+9VUeS7llrq3XXHtWlLXaScTM8xM9hWQLbCUhRmgESUx0lk5R/Gg3gl6mDO
 A9poysc4FL1sE4G7+tyNATkFErbqh2pbDgcV5WVahZbpFInhQ+dIYmV6eR9GDtd95uqoVmWK
 2CVUA9PCHkARk2OA12wdqnr/9TL9PKUQ/avN/abK6vbsvRQDr3boPDnmpsj5TuHMd+De2VvH
 +FukFQWRmh3QozQyTAIVjBRiC/HKcKW7B7u/ypqsoWv/vPxRwv16c2QBrEUPdgKmVj+iPWGM
 POMwSx+NDBT29UTyHWOxLVX1QwXjDxyMjK2G6kEtmiURaTcw+lcCBt+CWs7PZlN6L8gmwJWM
 snBkpWs37h017g+DFINQ1XlnovBidUiBWa7ORuHAU+KMO/DPjjX24TsZrv6T7RMjeJSvhn2u
 DCBEkalMC7R3z/uHwuiN+1BlkT5dFRXpZ29fxBxCGPiUMOuaxu1N8VyhCE3xrt8j23DNGoVO
 zxxO01XqbjY4SRdi/R5U2tPixgtZfGDgDqc5vLEJ4w+tPx2HmJrmugc7Hl7g7pZ4SdYReBkz
 Svfqtk9xjPu2uKLyzdhTF9PsmMR3d3N4h8kYPSDsMYQChOmtFoX4G6dCgoHvY5gA9zr4OVLz
 8TX0bn0MHFE+s7V+s0VA47VLtiGOTwvK0mMenacAQ0bQDqsLWyaiVZalaTY03SPrYUh7LXol
 oAPTLBzS1E/UP8XQBcAfpRKMNJsUzUonKTOxtYP/ma7pQLNSd9yu5faSrSNDP+pJDvT3twmL
 1MYhLj/K4oULIjy3UdvP0J7kIr9EE3VRdlRoydlY2fcQW1I92ViCHI+0QTpZ1H1iJf8PeG5l
 Fg6h1knCQzI3Cjh6RE7KwiSzBY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ss/lN6sEtrL956MPd9r1CO007skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHrJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3At952V2ltfjTl28XiJKMDLYzpDrvXOXjT4FfLGku?=
 =?us-ascii?q?oNV14E7+RcwDA3YdCzMU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ATQOtVw5JtQCV+dzChj6ExGhKxoxEspr2S2QK0qk?=
 =?us-ascii?q?LkMKpFR5TACmi1GuOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="108185050"
X-MGA-submission: =?us-ascii?q?MDEIbUPLDTQiJLk+JGTNUvru/h/zdfAm5Vryns?=
 =?us-ascii?q?u3v5fCVHyPUEhxvPgF9bc4BVqKNPhc5kt9eS/xPpiRLejf23vsM+wv53?=
 =?us-ascii?q?1Dvl3bXZxwIP3ufK29I8fiex3IaNZ4GfGLZVaK18Z5X5yWhV+mEzhD69?=
 =?us-ascii?q?/0ccjEQC4m4n96e6NNgg7L9g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:10:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738681819; x=1739286619; i=markus.elfring@web.de;
	bh=Z98A233FeCDkMDGKQ/s3CWRLEcEuU/sMmd8j+tLeLOk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b9HmHR7Q9eKNjvvk6TjOi2QMXCKWjX5MhYvH1Bf1dRiMy7Yoro6EBwZRumxiBp+b
	 CtKgj0e0GDFiEnN/zmWQwpHGo3t6ZL5dAzfNaaOVzRV0Xo1nAnrjP6QTGL13iuSqx
	 fClRDOK2OlbRRKnGa3zgawl7jJfpsiVOfxR3wDjJDTFNvAvDW3MThmB11d8Rp/4iW
	 /ngs1oV4tJCP3F545bk0bE1XgO93oqufu2Ipfj1tIZ4VeNiB7TrtgOQe80mESKZUD
	 9EyzJa18/kvB/zi03lt+lOjotbD4QRPJuXiXcmx+T64wcABntdJW5SOS9Er/LF9UH
	 q2NOTO6nTDH9nkhG5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30ZL-1tIfFn3SVJ-015mSY; Tue, 04
 Feb 2025 16:10:18 +0100
Message-ID: <5c5a00f7-8955-483a-9efc-d003972c7a12@web.de>
Date: Tue, 4 Feb 2025 16:10:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
 <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
 <66215b0-f6e-2cef-4022-4dd148fa2790@inria.fr>
 <CANiDSCvsBCrpwOFbwf93ighoMm+ca=jpHs6NAp9AHaEJj9neRg@mail.gmail.com>
 <1c92f6ab-9992-1f5-d911-f8cd52991c66@inria.fr>
 <CANiDSCvXUxdTxXZ9r3SvoVTnChkg1nRN7uAva8nHb6CTFt67KQ@mail.gmail.com>
 <5123b7fe-b5f6-4446-a792-b5d19873c181@inria.fr>
Content-Language: en-GB
Cc: Ricardo Ribalda <ribalda@chromium.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5123b7fe-b5f6-4446-a792-b5d19873c181@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZA+FCQOv4gqfahyo9DuN/czF77e9G1aRFRuvBcUHrqNW0EDUYS6
 zjvrCJtWPq/M/1poqnGV55XekHMSOAEjCxEbhFzRGeiGujQ6Td4xnuGnAynF8EQtCRGytWT
 qaqcG64FJkiliS5UfknOKIfxxJQTeRDyBwAdiZgPdvGDP0IK3ic/lBpdrMH1x5SdSrDkPQZ
 I038jvCgoGNky7G3h5Ffw==
UI-OutboundReport: notjunk:1;M01:P0:uLm+8FjLXG8=;Zb6EbqhA8JVAgJsz5PZmodDwtRF
 t0Bt9KuswsZJE6ukdtbWdsRzOIstrtXpPPvSS3bjYJcQw6ewMUMzh15A/Ma271qF2YHBodVy3
 rz49pqpr2umXXHb93RD4hAtKn3eh6J0AjRAA9axAAHP5txOi6LXfSwohntaqS6+AyS1rG6hZ8
 3xRsWlKsWlfl6lLOOiorgqf3rO58+eZ/9gi4pSANIdEZ/JR1XFje95pib2oHzrJLJoo+Yt8Al
 OdwkX+ALNEM0e/B9PdjveS3Pa7+wNtc88Pq9uUD8EDCAr0K1jaMR07xVgOjZLa9R4bN6G9ogd
 a4goKLm+F0EK+275dLl9Ud8FvbDgIy6iErigmmi1Oznu99nW1aYUIDdf8/U79yFgTn57ScbI5
 lBSXBexuFmrMXFoDgCqphBWN+qsXQ/rasbxmXi4j/tFPuvR4LFgQgLLQc0or4w7hQrchGoTEe
 MMY0HixvREVo81RMwgPYPunTfUJnJSoBicftJDSiMPfaVOiljsVvXPK6Slre7Ve6FAyphyLId
 8Yt6QmX1qJcXD+RmDBCiOU94ESQnuqae00/0dxNZbSrDSYn6q0yzfFqpwnZHLSuCYreoiIHIw
 yuBIT35xqpy+gxGTHMyZsWtDIBk+QilqBFMkLK+qETOUQ40Tp7zD4WW1jQZ9Ug8k4o8BxqtJe
 sCGTJNPl1ByMlXT/PM6pSMoMUhCaWDhD8qDoRh96CGuiYwINrRI1kEisG9Ce2HOf31w5d9kFS
 zER+krAX/okUyqbVEMLT8Cb1uSEB4AdCA08rtzdXd2eA21xsREMuxedHgJPepvbBu2LQ1QPww
 EOeIm5M1JtS5fUZlFI6+wxVbbVz8M0Gqr29YdJffRvrBpXg2fvUnQyh5EL21PNeZVSUv13DBA
 ssjwOMrPeydzamYJzFiYxei1jRlI2ceeX/1KVMc0KFf9IM37NZWlQgbmeh16EaoxLocsFpW32
 7IvHvc37mAtp+70xcLagETzk9JTpoww7tVp/qEYPtmBLZ5PXaLYbLCNK1xjnMGD/RDZIheA0n
 C51Nb4bIR/AV2OWya6indhI9KnDEKFhx+Rm8Qk3llaOqkOvfRNgMd+bKhUzDDcekP+hP/gM8Y
 y+QWkT5Vyqdq4OwkiJf/Q7sdByT5QsHMLFVA15NBCbno3ckBppTx9FQwCgixf3ex3EsfPtMAs
 6KLRICj33+l4/pM7OjT1vHo5ZJlN/bmRICC4jJrwVOZDiF0pjDJVFvRPZdOhY9+1eM85Haect
 Fy0/cLP6GHt50m29KsMTQlc3Lj7u1mGPl+4+A/tZ6v3ino6vjxm0iY3o8CC4lJYokNcsgh35G
 W9oY/Wv0yVztrRORHkxXJvk6NKpOj1ye0RDfGNFouVWBOou+wIBk19K1ouA26aHFYPqSC0a8y
 KvGqQrhqzezXvBk0FOn2ut4c1ELvUKPRA4Kvo=
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2341
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/5c5a00f7-8955-483a-9efc-d003972c7a12%40web.de>

=E2=80=A6
> spatch version 1.1.1-00610-gd151c4895 compiled with OCaml version 4.13.1
=E2=80=A6
> $ time make coccicheck M=3Ddrivers/media
> real=C2=A0=C2=A0=C2=A0 14m31,975s
> user=C2=A0=C2=A0=C2=A0 92m46,656s
> sys=C2=A0=C2=A0=C2=A0 0m47,545s
=E2=80=A6
> spatch version 1.1.1-00611-g4388e1d92 compiled with OCaml version 4.13.1
=E2=80=A6
> $ time make coccicheck M=3Ddrivers/media
> real=C2=A0=C2=A0=C2=A0 33m0,638s
> user=C2=A0=C2=A0=C2=A0 218m47,039s
> sys=C2=A0=C2=A0=C2=A0 1m13,807s
=E2=80=A6

Would you become interested to increase the measurement granularity anothe=
r bit?

See also:
Selection of benchmarks
2018-04-24
https://github.com/coccinelle/coccinelle/issues/133

Regards,
Markus
