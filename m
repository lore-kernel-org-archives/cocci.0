Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99BCC00140
	for <cocci@archiver.kernel.org>; Sun, 21 Aug 2022 08:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GPpLKavxajv+GJbpby2W2mZobu7EXm5pLBL4GwY241M=;
  b=au5GdK4Ez+tTrdJn26XYDQO8jFagDbQarSlFcRkzxg13O8Q+1gPs4aoF
   bGxHeVr5v42BZrpx2yb1+E9lJmWnjN3cp3gdMl/gvTzcxW+Sc8yFy1ETp
   svuXbQpzNBTYGrUjaoAJBxWufYLdM6QxZq0VK7COtv2hujsUayfqVG90V
   k=;
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
X-IronPort-AV: E=Sophos;i="5.93,251,1654552800"; 
   d="scan'208";a="49368495"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Aug 2022 10:11:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6C794E0385; Sun, 21 Aug 2022 10:11:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4919AE00F6
	for <cocci@sympa.inria.fr>; Sun, 21 Aug 2022 10:11:04 +0200 (CEST)
IronPort-SDR: CfeCtBiu+MeGXhHW3geOHk7LZkLJdIpVymMhg+xEFht+5ZT5IPJTriH70AJ+iQkrEM582StZOh
 BXPv/4iPKrU9SGxL9j/63+PghMKfG5gBp6gW17ggN08IpsA26RY7IFyl1IejACE9otstK9W0QH
 HOhTHLAFluh9zNJ3SGlE6HE5rKP6//oZTDxnvXyibrwRfGM4h8ckdYx09wjvZ9xhK3ZsI/P8cN
 brK7KlXC5+4SH6Dp+uiWkwUigjXEbq/TgCY9AhCb9I6Nsw+pKxQQqX7btdHnbCNZmKYkQvDMF9
 QHLyg6VmRuA2tKj74l8DzCGo
X-IPAS-Result: =?us-ascii?q?A0B9CABU6AFjhwsR49RagQmBUYIigVguBAtFhE6OZ4Ioh?=
 =?us-ascii?q?CWHEocgii2BewsBAwENPwECBAEBghOCdAKEYQIdBwEENgQNAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZASBSwSBd?=
 =?us-ascii?q?As0DYI1KQGDZAECAgEjHQEBESYBBAsJAg4MAiYCAlcGDQgBAYJ5gm0BAw0lB?=
 =?us-ascii?q?4xdnBSBMYEBgggBAQaETh8sIlKBXAmBES2OWnonEIFVRIE8gwM+hESDVoJlm?=
 =?us-ascii?q?W4mBA4DGiseQgIBC0MFCAkXEhAQAgQRGgsGAxY+CQIEDgNACA0DEQQDDxgJE?=
 =?us-ascii?q?ggQBAYDMQwlCwMUDAEGAwYFAwEDGwMUAwUYDAcDGQ8jDQ0EGAcMAwMFJQMCA?=
 =?us-ascii?q?hsHAgIDAgYVBgICTjkIBAgEKyMPBQIHLwUELwIeBAUGEQgCFgIGBAQEBBUCE?=
 =?us-ascii?q?AgCCCcXBxMYGxkBBTInEAkhHAoEGgoGBQYTAyBvBQo7DygzNTkrHRsKgRIqK?=
 =?us-ascii?q?RUDBAQDAgYTAwMiAhAuMQMVBikTEi0HK3UJAgMiaQUDAwQoLAMJHx8HCSImP?=
 =?us-ascii?q?QUFWzoBBAMDECI9BgMJAwIpOwKaGXKCC8MkNAeCFoE/gUUMnj4GEy6WZQ4Gk?=
 =?us-ascii?q?XuXB6dfgXsGgXUzGiSDNk4BAgECDQECAgMBAgECCQEBAo42hAyKLT80OwIGA?=
 =?us-ascii?q?QoBAQMJhUcBAYUTAQE?=
IronPort-PHdr: A9a23:hOTW7BwwNsddZ7LXCzLWwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 heZv6sxxwaTDM3y0LFts6LuqafuWGgNs96qkUspV9hybSIDktgchAc6AcSIWgXRJf/uaDEmT
 owZDAc2t360PlJIF8ngelbcvmO97SIIGhX4KAF5Ovn5FpTdgsip2e2+4YPfbgRHiTayfL9+M
 hG7phjNu8cLhodvNrw/wQbTrHtSfORWy2JoJVaNkBv5+8y94p1t/TlOtvw478JPXrn0cKo+T
 bxDETQpKHs169HxtRnCVgSA+H0RWXgLnxVSAgjF6Bb6Xortsib/q+Fw1jWWMdHwQLspQjmp8
 btlRwH0hycGLz458X/YispsjKJAvRmtowVzz5PIbI2JMfZzeL7Wc9EHSmpbRstfVCJPDYyyY
 IUSEeQMI+hYoYn/qFQSohWzHhWsBPr1xzNUmnP706833uI8Gg/GxgwgGNcOvWzTotrvLqcSU
 v21zLLVxjvMa/NW1y396InOchAuvPqBWrV+ftDLyUksCgPFlU+cp4PhPzObzOQNsm6b7+V7W
 OOhlWEosBt9rSWxyco1jITCm40axEze+ypj3IY1OcO3SFR9YdO8HpVeuSCXOpZyT84sTG9lp
 CU3x70It5KnfiUHy5UqyhDDZ/GIc4WF/A/uWfuPLTp5h39oe66yiheu/UWh1OHxWM+520tJo
 CpditTAqG0B2wLJ5sSZVPdw/F2t1SuN2gzJ9+1IPFg4mKjYJpI7zbM9lYAfvETHEyPsm0j7g
 qmbfVg+9Oey8eToeLDmq4ecN4BqjgH+Nbwjmsm4AeQlLggCRWaa9vqn27H54EL2Xq1Gjvwwk
 qbHrJDXPdoXqrOnDwNPzIov9RSyAy273Nkah3ULMU9JdAqCj4fzOlHOJP74De24g1SpiDplw
 OrJPqfiApXQNXjPirjvfbJz605GyQozy99f6olaC74fO/3/QFL+u8LAAh8/KAO72/znB8ll1
 oMCRWKPBbeUPL3KvV+S+u0vO/WMZJMSuDvlL/gq/fDvgmU9mV8ZZqSo3JoXaHWjEfR8OUqVe
 3vsgtEbEWcLpAUyVuLqiEeaXT5Je3myR7485i08CI++EYjDQZyij6CA3CqgBZ1XZmVGCkiWH
 nvydoWEXe0MaCOILcN7nDwET+vpd4h09xitswWy6L18JerZ/mVMt5HnhIItoeLSiTk98DV1C
 4KW1GTbHE9umWZdYjYs371k6WF5xE2C16cw19lRD99O/LVkVgkgNJjT5/N3AZb+V1SSLZ+yV
 F+6T4D+UnkKRdUrzopLOh4lcz3DphXK3i7wRqQQi6TOHps/tKTVw3n2Ic95jXfAzqgoyVc8E
 YNULWPzoKl5+kDIApLR1V2DnvOPfL4fwTWL2WON12uIs2lHXQQ2XaiWFWsHaB7upM/irljHU
 6foDL0mNgVbzsvXD6JQacDyy3hCSu3iPtv2fG+73Wu9Vl6T3r3ZSo3sdi0G2TnFTkgJlwdG5
 XGdKQ03HTusuUrbCyFyU03iaQXg/IGSsVudSUk5h0GPZkxljf+u/wINwOabQLUV164FvyEor
 3N1Gky81pTYEYjIoQ0pZ6habd4nhTUPnWvEqwxwOIChJKF+lxYfdQpwpUbnyxRwDM1Jj8Erq
 HogyAc6J7if1RtNcDaR3Ja4PbOySCG62Rm1aLPNnHza3syX/Kgn9/ky7Vnu/UmoGkck73R7w
 oxNyXLPrp7ODQcUTdfwShNtrkI8/euFJHBiodqNhhgOeeGuvzTP2swkHr4gwxekJZJENb+cU
 RX1GIscDtSvL+ojnx6oaAgFNaZc7v1RXYvuev2Y1aqsJOslkiihiDENxYln0V+XsQd4RPTJ2
 Zkt3PySmAeKHWSZ7h/pooXslIZIaCtHVE+20yv5H8h8YqNofIAEIXijKYu7y58t4vylE24d/
 1mlCVQc3cavchfHdF3x0zpb0kEPqGCmky+1p9BtuwkgtbHXnCnHwuC4MQECJnYOXm5py1HlP
 YmzidkeGkmudQkg0hW/tw72wK1SpaI3KGe2Iw8AWiHsLHx5FIa0uKCDZcFn954i9ylaGOixe
 lGVTLfhrgBSiXq5WTEEm3ZiKHfz493whFRihXiYLWpvoXa8G4k43hrZ6NHGBLZQ0jcAWChkm
 GzSD1m4McOu+IbcnJPCv+aiEmO5A8cKK2+xl9zG7XT9vDQ5ZH/31+q+kdDmDwUghCry1t0wE
 D7NsA65eI7gkaKzLeNgeEBsQl768ctzXI9kwe5SzNkd32YXgpKN8D8Ji2D2ZJ9+0Lj9cWFLa
 DoF2d/T7yD61UclIn/DlOebHj2Nh9BsYdW3eDZc/ysn7N1RToqQ4qZFmyRdvVey6w7cK6sY/
 H9V2b4l73gUhPsMsQwmw3CGA7wcKkJfODTlixWC693t5LUSfmukdqK8kVZvhd30Rq/XuRlSA
 TyqH/VqVT819Mh0N0jAlWH++p2xMseFdsod71WVi0uS1bEPbshrybxT33QhYDit+id4roxzx
 R12gcPg5dLBcT8yuvvkREYfbGC9ZttPqGu01+AExJnQht/pRtI7RX0KRMe6F6v3Vm1I8622b
 UDUTG178Cb+e/KXHBfDuhc86SuRTtbyaiDRfD5Dk51jXEXPfhUAxl9OGm9iwdhhUVr1jM35L
 BUjv29XuQS+80oWjLw0cEOhNwWX7AawNmVkEt7GckcQtFsToR6OaYSf9r4hT3sep8P86lbWc
 irBPUwNBGUNECRoHnjFOb+jrZnF+umcXK+lKufWJK+JoqpYXuuJwpSm1s1n+SyNP4OBJCsqC
 fpzwUdFUX1jfqaR0zwSVywakT7MZM+HtV+9/CNwtMW27PXsXkrm+4KOD7JYNdgn9QqxhO+PM
 OuZhSAxLjg9tNtE3XjT1L0Wx0IfkQlrcCSxV6sNv2jBQeOYm6NaCQIadzImNMZM6PFZvEEFM
 srah9Xpk79g26RsUREfDwOnw57vPJVZRgP1fEnKD0uKKrmccDjCwsWtJLi5VaUVluJf8Ru5p
 TecFUbneDWFjTjgER61YoQuxGmWOgJTvIalf1NjE2/mGZjDYwe4LcQxoDk427wyiVvVOGRaP
 TU2ICYv5vWAqDhVhPlyATkL9n1+MeyNgDqU9cHdLYsK9+RmCGJ4mqgJhRZyg6sQ5yZCSvtvn
 SLUpdM7uFCqnN6EzT9/WQZPoDJG7GpklVpvM+PV+8sZMZ4l1BcK8HnWFBkA4ddoWIWHU0V41
 dXF0q7+em8qzg==
IronPort-Data: A9a23:6ZEv562NTajvTiCQePbD5fR3kn2cJEfYwER7XKvMYLTBsI5bpzBSy
 zEfCmGOP6mIYGKmfN4lboi28RkC6sDQnNdjTgJr3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywIbVvqYy2YLjW1PX4
 YuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt/dLl
 sxLi7mycho0JoLDnssmTxtZFwgraMWq+JefSZS+mcmU0lGAbHbmhfljZK00FddBoKAtWz4Ir
 KNecWllghOr34paxJqeQ/Nvm99lAc3lJoIZtVl/wDufAftOrZXrH/SRu48EjW9YasZmTa/OQ
 OlGcBxVVj/NfVpoYlg6V9Ukg7L97pX4W2QF9AzM/PRfD3Lo5Ah4z7HpNPLHe9mAX8wTn0CCp
 2uA8X6RKhodP9ee4SGU92qlwO7JhyLyHowIfIBU7dZvh0CPgHMeAlsaWDNXvMVVlGaZYYxGL
 XIx+BEzsLAd+0qEdcX/XhmR9SvsUgEnZ/JcFOgz6Qeow6XS4hqECmVscgOteODKp+dqFW17i
 gLhc8fBVWcw7e39pWe1q+/MxQ5eLxT5OkcuSEfopyMm6sPnu5sujh+noj1LT/Ds1YCd9d3Y6
 TmGoS57uKgJkdIG0q+251+vvt5Bjp3OUxJz+QjdGG6ohu+YWGJHT9z5gbQ4xa8RRGp8crVnl
 CZd8yR5xL5XZaxhbATXHI0w8EiBvp5pygH0j191BIUG/D+w4XOldo04yGggeh4xaJ5eI2K0M
 R67VeZtCHl7YyvCgUhfPNLZNijW5fOxfTgYfq2IP4QVOPCdiiferX8+OSZ8IFwBYGB1zP1hY
 M7FGSpdJS9UUOxmyia7XeEQzfciyUgDKZD7FfjGI+Cc+ePGPha9EO9bWHPXN7xRxP7a/G39r
 ogOX+PXmk03eLCvOUH/rN9DRXhUdSVTLc6s96R/KLXZSiI4Qz5JNhMk6eh8E2CTt/8Px7+gE
 7DUchMw9WcTclWcdVnWMiw9Neu+NXu9xFpiVRER0Z+T8yBLSe6SAG03LvPbpJErq75uy+BaV
 f4Ad5nSC/hDUGqV5DkXK5Xw9dQweBOujAOIHiykfDlmI88+HVOUoIe8c1u97jQKAwq2qdA6/
 e+q2DTbdpxfFQ5sO8DbNaC0xFSrsHlBw+9/BhOaItRadEj23pJtLij90q0+L80Wd0fcyzHc2
 wvPWUUUouzEookU9tjVhPnY/tnzTLYkRhJXRjCJ46y3OC/W+nuY7bVBCOvYLyrAUG7U+bm5Y
 bsHxf/LMMoBwARAvb16Hus51qk5/dbu++RXwwk4TnXGa1OnVuFpLnWchJAds6pQ2vlGtAHwV
 k/WootWPrCAOcXEFl8NJVN5P7rZiqxOwmHfvaYvPUH3xC5r577ZA09cCBm7jnAPJrVCNo54k
 /wqv9Qb6lDkhxd2YMyKiDtYqzaFInAaCvx1s5YHHMn0hwBtxlwbOc7QDSr/4ZeubdRQMxB2c
 2HO2/eY3+xRlhjYbn4+NXnRxu4D154AjxB9ygNQLVq+nNeY1OQ82wdc8GhsQwlYpvmdPzmf5
 oS224xJyaSyE/NAgc9eQyazFgsHCBDxFokdDbcWvDWxcqVqfjWlwK4B1SKl400TtW5RFtSe1
 K/N037rCF4GY+mothbfmidZRzjLUtF7sAHP8Cxi8wJpALFiCQfYbmSSiabkZvcp7Q7dRKEKm
 AWywNtNVA==
IronPort-HdrOrdr: A9a23:n7bSjavMlkbomMLxPhwQgUqC7skDUtV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+VvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,251,1654552800"; 
   d="scan'208";a="49368490"
X-MGA-submission: =?us-ascii?q?MDHZVrqF1vI8OPf8WUuzpYqNR+4aFrqmMO5rEn?=
 =?us-ascii?q?aswWoZpaEVnUFldgnufSRQy1ApIBI40+ED97/Oqk7kTYvVphaQP85XZP?=
 =?us-ascii?q?7OoYvDJFanIiC+ie8OkFOEw48ClzHkbl5KL1WwaA0C4p6zUIrbGJJZbU?=
 =?us-ascii?q?JmYsBAs+8f8jpGMSVWnLjFdg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 10:11:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1661069461;
	bh=GPpLKavxajv+GJbpby2W2mZobu7EXm5pLBL4GwY241M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KZZp+fHuLFtp9nJ/MObxdF7GP1vOya4yNpQ+G5E8amuhSkNsWu83QwmYY9kY30HOt
	 n/Zb0pi/H3KdFAmJnBG38I25s1a2pxpk/C8pdlv80LMHwoh706+nGpweHqDCfS5UpG
	 6FgpuW8gvJEmvoLC+Wzg3akqfRsGMWq2oe0cu/+4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.48.59.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi5i-1owa4r0DPs-00XIii; Sun, 21
 Aug 2022 10:11:01 +0200
Message-ID: <26cfb01d-0d74-1c34-ac60-664c61931f07@web.de>
Date: Sun, 21 Aug 2022 10:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
To: Jakob Koschel <jkl820.git@gmail.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
 <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
 <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de>
 <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
 <d9e428c2-f4d2-13bb-bf42-447a1f0ffa73@web.de>
 <5369B40D-9EA4-401F-A9CB-2CA1C0E3332E@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5369B40D-9EA4-401F-A9CB-2CA1C0E3332E@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tr1egDgW6VK3wbnBlnT4Y3/Cqy0nVsf/Tx1ObDNElIWK9+6iPI5
 8mbtohFwtbTHyDBVCEP35ED37IlpoROMtkVpLjQoXGTSEKPc/iu9/5CqUxpiPZ5gQGlvCEk
 7HzcomjUuDrcIPnpulp5pNtqrfMXhq/VaFO7Sp69BeM1069S6TqmT1tHrFiQ4rNBtTy8RUQ
 C8vm1pwt3ikxgDmehOQCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JUoXg6pqvuQ=:qb8VWqShD96gojNKfwNJM+
 xL3EiKVJ1aKFTplcGI5b8k2K3YJpS+YxAXVB26M78DlbPxR/tHd1a23h+bG/4hQkEstGLYiN0
 1zs/32ew5M7hxRpEDj5S/S75kbjX3/GxQHj6x4wI528JCp51Exi5ZunX2VqHCu2nS0n+6tZ2n
 Je0P48JdGIFYi6upf2HnmtK3YdAfAgorr4bSHx0wCvEUG/BZwPiiDjvpT8jgnNT7Xy74aF9L8
 N3HlrjropDDvvmMkmMl3lsoPfuWMt5zoHfHKF8NYvTwYwvWUB4VlzSx+lPQkQ472AnPjuV7Zi
 7iYZnztvg3Ej4uttLrKGVpBnR/qDhLAm6F4zUrkpuCgWY0B+iEonEkwV9wFBdp+05KR/RPfJV
 g5OISRvdVbGG/mL4g6Umu6z7ge+xB4KbsYmSGVtzC2jx5lv6PUcsWjlxsOg6WvClbMLOoNFe+
 H3E31w9u9WptuZA/bvdKEk91KJQvQHRAeiah4fUJro0EhoV5a/RBMGPxx9/1BuTmqkX0mcmHR
 e95Otp4YMxjJxhJNI9RrxU5YTqY1Z32ms4efo40A0t9s7AZcXJsPAt7++tIA1DL0ZaOh73hjW
 4H4WplsmqQHKvyBORnY5mDN/oDeoeWU1vuek6NjeLFEkMhXHTNWne9Xc45ASO1bmBuzZTnIBA
 kzodq/MGqrKEC6vIsAVUgbzxlVoUyzqpRgBRDHJRVZZfmZlTAFvm7UH2pxaPqDh6twxFWsMrW
 9q4HFsImBSVJ86D6U+Ly1mh91fLnoo7+VGxC7Rv+DOIMl3AVQw1YtQhdYUhmf1UtDQpJEyMLi
 31AJN8whmbEEEHwhJIxqfRIcrM+KPHa8GMJTyyRGYXRaEpUOu5CYoIQOJbc65LwKf9nWtMD51
 FUvkzDYVim1+3vKl750roi2qZUTwrb+ueq96ipJcSiuGr3stQw2CBAMbvCtKePq6se9RzCYQf
 c4Po10V0yF+K2fR8Eyo9PJrsu0Sp/RjSy+YGnPr+bFbBuDoG72AzcZLz7g+v/7lBCYen3pipw
 YZewKzmhZNa4Dav+Fnn3OwIif2Y6Nxm+yP0U5j/ZtKIjxnGCuDplcZuDNpDYTKSXs65upTrvV
 FcMGCltgWQD51BPjYorgS+PBk/zjyKYCdrtBsj3lyVdpMEhyxJ2m4V1Qw==
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 526
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/26cfb01d-0d74-1c34-ac60-664c61931f07%40web.de>

> I'm not sure what you mean "link for this evolving information source". =
There is no
> public information on this yet since it's an ongoing project.


Are you looking for contributions from related research groups?



>> Are you looking for better source code formatting according to semicolo=
ns?
> I'm not exactly sure what you mean with that?


Do you care if a bit of code which is probably relevant for the programmin=
g
language syntax would be commented out as it was indicated by the diff fra=
gment
=E2=80=9C+=C2=A0=C2=A0=C2=A0 // test;=E2=80=9D?


> I've only used adding the comment to see if the matching works correctly=
,


Would other code variants (than C++-style comments) be more helpful for
the demonstration of desirable transformation effects?


> I'm not intending to do anything with comments in the final version.


My software application expectations evolved into additional directions
according to mentioned change specifications (in SmPL code).

Regards,
Markus

