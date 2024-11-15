Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD98D68BDA
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=C//qZdfJfhN40N7nu/AQ5wmq+hj+onzvFzX2KrlsiOc=;
  b=Q7+U0TM4+R6YLM+3Ih7OXUSUKugfaZKe4D6fOT5YFoyxSBBWB6wvX5cV
   rSuoPqXZk0kMrMmJ3Cu0EL97q07bsoAqcsxXo5LBGcal8DlCtLJFn5BxP
   xtmBykpnncOKXwb76Y39MTPawVgI0NNOMj2fQSq7tuHm3aR8VZJIhbxfq
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194170197"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BB249E0E25; Fri, 15 Nov 2024 23:36:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CBDA7E013D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:53 +0100 (CET)
IronPort-SDR: 6737bc9d_D0o5Q4MF2lSLQfGpFAnfKrKlaUY39T+f1I1AfsJt5GnSzme
 YYyOsmwk6NC4MEMC7QtG1+N5/jit3AXWFuNkUCw==
X-IPAS-Result: =?us-ascii?q?A0EgAADnuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9LAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoMzhApOg0aCaYJFhRMlhQaDe?=
 =?us-ascii?q?Zl+CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bIQtcg?=
 =?us-ascii?q?SmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCTmQyH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefBEaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZSKoV?=
 =?us-ascii?q?IIYOoFcRgcjFYMiTwMZD44hDBaDWI8+AbYeQzU7AgcLAQEDCYVGAQGJWzSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23:6LyuuxWT6xY4alZAveKT6q7dKN7V8KwzQjF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBtydsa4P0raK++C4ACpcus7H6ChDOLV3FDY7yuwu3DYcSPafDkP6KPO4JwcbJ
 +9lEGFfwnegLEJOE9z/bVCB6le77DoVBwmtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJ
 xmqsAndrMYbjIV/Jqor1BfErXREd/lZyG5nOFmfmwrw6tqq8JNs/Slcp+gt+9JcXan/Yq81U
 aFWADM6Pm8648HmqQPNQQyT6HUCT24YiABIAw/L7BH7Wpf+rC73vfdj1SeZIMP7U6k6VSyt4
 Kl3RhDojjwHNyMi/2HMlsNwlqNbrwm/qBF53oXZfZuaNPt6fqPaYNMaWW9MVdtfWiBdHo+xa
 ZYEAvEfNuhEsYbyu1oOrQO/BQayAuPv1iRIjWLy0aEjzugtDR3K0AkmEtkTsnrbsc/1Ob8SX
 +670afHwinMYfxV1zfz6ofGbA4sr/aXULJsc8fc01UjGhnZgliSr4HuIjOb1v4Ks2ie9+duW
 vigi3Upqg5ruDik28UihZPThoIUylDL7z95z5wzJdalT0N0f8SrEJtKuCGANot2QtktTnpsu
 CY7zL0GpJG6cDIPyJQm2xHfcfuHc5OP4hLtSOadOyt3hHVgeL+mgRu57EevxPHmWMauzFZKs
 jRKksPKtn0V2BLe9MiKR/p98Eq/xTuC2Q/e5+BFLEwql6fWKoAtzqMsmpccv0rOHTP7lUHrg
 aKVdUgp5Oim5ev7b7voupOSN4l5gRz9PKQ2gsGzHOo1PhIMUmWZ4+iwyb3u8ELjTLlXjfA6j
 LHVvZ/GKcgBoqO1HhVZ3ps+5xqhFTur1NAVkH8aJ19bfBKHkpPpO03QL/DiEPm/glWtnylzy
 v3GOLDqH4/DIWLZkLj7eLZw805cxxQ3zdBY/59UDrABIPTuWk7+rtDYCx45PBCuw+bgE9V90
 Y0eWX6VDqCFN6PStEeE5uMpI+aSeI8YoCvxJvY/6/Psj3I1g0IRcKmm0JcNdXy1HepqL12cY
 XX2g9cBFWkKvhA5TOzvkFCNTyRcZ3aoUKIm5zE7CJipAJzHRoCshryBwSi6EodTZmBHFl+MC
 3Dod56DW/cCdCKeONNukjsBVbS5TY8uzgmhtBXmxLp/MurU5ioYuIr92NRt/e3ciQky9SBoD
 8Say2yNS3t7n20SSD8y2KByuk18ylaG0adjmfxXD8Zf5/JPUgcgNJ7T1fZ2C97oWg7ZZNeGV
 E6mQsm6ATE2Vt8+39gObFphFNWjlR3DxCqrA7oNl7ORHpA086Tc32LwJ8ln0XrG2rMh3BEaR
 Z53PGeigeZZ+gnJDsbggliCkO7+ba0W2Cnl8mqfw2uKoExCFglqXvOBFVIYdFDbo5za70/GQ
 rS1CLdvZghIxcqPIYNMZ8HnjFFaSe2lP87RNSb50Uu5GxeEjojKJK/rf2EQxm+VXEQNjQ0W1
 XqPKwU7AiCvvyTYASA4URrCeULnucVjrXqpQ1N8mwyGckhoxbep0hESgvOYRrUY2bdS/G8Do
 jZpFh6e3tnXDcGDpkI1f7hWaPs+7U1B2GafsBZyaNjoF6llgllWWg56uUKmgw1+AIhGkOAwo
 X8qxRY0IqWdhhcJTDKd2pa4GrrNL2D0tESvbLTTwXnd3cyQ96NJ7+43/RGrnhytF0Nq13x42
 t1Rmy+++5HLBUw2WI34VkIf9h5gpricbDNro8vy1HZrNaCv+gfL39M5TL8jyx2ne95EdruNE
 A7iO8wfDsfoJvZ83xCFZxQFMeQa0ac/PIvye/KA2aOvFPRnmiu7gCJA+o8rlgqs/i1+S+fOl
 6QF3vie0UPTVz77jlaotIblmZ1NYz46EW+2yCyiD4lUMOk6R4EBBH2ya+++3Md7hp2lD2Rf/
 lO5GxUE0dW7fBuRR1Ln0AAW215B5TSdhDCjwjhw2xIoqKXXiCjPxfnyXBMdP2pKQnRyy1D2L
 s6pjIZeFGilbgsu3DCs/13myq5A7PB/JGD7RUZOYjiwLmtnFKC3s+zGK/BG85IsoG14V/62Y
 FPSHrH6uTMe0iX+Dy1fzjV9fDav7NGxthh3mGubIHtp5FXeY819yAmXsNXTQuRd0zcYbC15j
 yTHQFm2Op+i+tDC09/osvq/TH6gX5sbWy7xy5+avSa06HciVRe4hfavgNTqHgUg+Sv60cR6E
 yTCqVD3ZYy9k+yBL+9hNnJjBFnx7853UtVljIY2n7kU2H4HltOU939BmmD2Z5ET/qz/djInR
 CIXxNidtA/v2VF/KXShx4vzX3OUhMJgMZ3yRW8b1moS5spAAbbcuLtLlCF/q0uQrg/LZ/V52
 DAHxq1qoFoHiOgS8CYghgCUGLsSHAEMOTHnng/O4927pb9cZGeHcL6s2U44ltekWvXKngFbX
 X/iMrcvGStr8t/hNRqYzH3074j/PtndadYIqgeTlj/Eju5IONQwkOYHgWxsPmer+TUfzOIhj
 BNpla+7oonPf39q8Li4DRkeKDzrZusS/C3gieBVmcPAm8iKF5x7BjgNFL/hS/GoFygJqbyzM
 g+HCiExrDGfELzcHQiF81tOq3PJDoDtNneLKX1fxtJnEl3VAUVPgQUZFA87hpcjGkj+wdbga
 E5j6hgS60T+px8KzfhnYV23bmfYoQ6zIgU1TZ2SNh9f6AcKs1vHMMmb4/h2Fide1oa8twHLJ
 mHNI0xkBH8IVgStBkrnP7TmsdDB6eyZC+aWIP7HYLHIoutbAbPA/pOq1Y1vtwiBKtmCJDE2F
 Pw+3UxKdX53BMDd3T4PHWhftS/XaMOd7BuxsgdwtNujuKDpVRjo6I2DAZNdNtJg/x3wiqCGY
 arYvDxwNztV0NsvzHvJx7kZ0VMeimk6bzqkFbUPtCjAQa7RsqBQCBEfZmV4M84eq+oH3gBMP
 cPdhpve1rd+grZhEFdMVFjsnM2BassNLGWwcljAARDPfJ2AKSfG3InTfKW6AelZiulOugLzv
 zuHH0L9FjCekT+vXBD5daluhSSWJ1RlvYinbl45C2HmQcmgcRiyKsNfhycxyLE/gXaMPmkZZ
 3w0X0JGrfWz4CVej/luUzhN73Fma+qJnSCU4/jwIIwRuPdgBSEynOVftjBygZlc6SxfDNEzu
 m2ahNlyv1ajluSegHIzchNLpy0NroWXoUJnPajI3rlJX23J+ioE93mWBg4Rp9p9TNbovvYUg
 pLqnbjvKTEK0JScxcYACtLPJcTNeC4kOAD1GTiSFAYZQCSwOGf3gFZUm/WfsHaSq85+4qLrl
 5cUAodSSRQQEfUciwwxBtsNLY0xRjo5ubWakNQJ9Ty1qxyHAI14s5bcHtuCC/LiYGKQnbNDa
 jMLzKn+IIBVOo6tnwRBY11+kcz0Ek7XFYROvCRlaSc3rV9L/Xw4SXc8jQatSA6j7jcxEv6yh
 Rkwwl98Y+Mt8izr5X80K0DMqS92l1M+z5GtqjmNeTrwKu+VVJtXDSPv/xw6O4/yRwdzKwi7h
 01iPSzsTqhUybBncDYvwCbatYFCBrZ5SrdYZxlYkfiUf/AA1VVatzXiy0ha4+fMFZplkk0ta
 5H66zpi0glgJOE8I6OYcKhIyEBNwL2HuCCA3eQ23QNYJkEL93jUcykN7ghAE7A8LCestsxr7
 RCHkj1FMDwJXuAhr/ZC9kQ5J+GJySSm1KRMfAT5FeufJqXRm2XMn8OSTRtk1EQInk8D/bV62
 8o5fGKbUkkuyP2aEBFfcYLmNABHJ+NP+2XIYSHGr+LLib54OZmvXrTsUO6c8qoZhF62NAksF
 oUIqM8GG8/omG7CIMivD6QCwBVoxA3xOFCMCrwddwiGnzQHi8W+yoJn045AID0UHWR6N2Ow/
 LmB4kcEhP2ZXd4wKlkTX40JMnY3EJm0nylDvn1GSje+0+QUzAyDxzXmoS3cBz75KdFkYaHQL
 SllGZmU5DR3p7K0lF//+I/ZLm3xMtEksdjKv6dSnJ2AF+8cZ6N0tUvRncEMXHawWmjDHNidL
 YL3YoUnatmyAXG/BBj3oSgyRsv6O9PlL66UjBvuTIIcs4SB2j0nfdWwCDATBF90pvofrPZ2b
 ghGYJchZxPs8gozOqC1KQybl9GvWHqFIyFRRvVUyuD8bLtSmW5kXu6nwnxoapBym/m27EQJR
 bkQgx3ezOrlbI5bB2y7O3hMck3jvzs+km9/frIzzv0uxxbPr3ETNjmKcKpib2kS+5keAkiSa
 U1xC28yQFKBg8KX4Bar3rUY+CZ1nNtO1+BB9n/kscmbKBCtQq3jipLOsiwpJYwkoq52KqTgL
 9GAuZeYmSbQGt2YlwyfVzW+HuQSsNVWLTkQFPxClGcoIuQdpJFMr0EjAIN2H7FTEuEJormmZ
 DksWTYXySYVWoCoxyEZj6G33L6M0l+yd5lqFBUbqphEidZVByxxb2UarbC5WoPdmkeeR2QLK
 RtV5gNJskZItIZqefvh6ZSAb45Xxjpf66ZsXzHGBrFw+kH2Wiedkw68AMmokOWy3QMa7e3l0
 5FPRB9gAEl13PtNmw0jL7Qhb+E0o4XDqXezaUrxvCq5zK29OFBayeXMelv3EZbfsmz9QmsQ9
 CtQDbVS02rSEZBasAt/Z+5/oFRKPZDld1r47iIl2axgBby8VMa21xAit3lAWiT8V5JqC/tnq
 07WUTstTJWmqZPoId0GSW9K+YaBql5f1kpoPi+/xIB0JMRE4zpKVz9K93HVmNyvSdYL4cJ7C
 YREdtN4pnbmXrtJNZ6Ki3YxoL3gy3nUvTs7tQH+jBCyEK+xQuYR0mkaFx8sLmLW/kw3AsMh9
 mPf6FXEtBZ186FSG+7LxWNwqzZ6GplVTg5I2n+kKRwnSmFHvOpbLozadsVdR785Yhr5f1QVF
 eQnxFCO5UF51VP0eStj/l9R+zrcRBUzTSkYxLPggzoPgsq8NiUdVooOYCh3K2/jIhyWlCYfm
 l5lYkYiD5YQHNtI/ZkY0JFS886ETlyjf2VNeRVuNgsm2PwXrlRCtkSGcDvUC0L8cP/Dvgxfe
 caXsd7vLf78ugxAj9W0nvo/8vAuTma5kBflYdnEro/1rNSM/h+DfafxKey8aFfFTT7RnVa1h
 Lw+CILN8TSVOw1efcopgUE4aITsXDaYdS9NILgWcg8CDfgSgbRup+lbY5UhY6MV4ep3ARnBQ
 BrzGYuppf0AL1DJRD2YIT/Suvenr9f16rrQAfPletTK32zOFq9+Pp5g6DnyM7Pr15JOvE/30
 e1q7UR0VR7NNCXS5M/5KFYz7dK5PlDnooVvGDrXBJlql3+4y0hAftAWQySC9JUe1YMf7Xf7U
 +Vj1Ubv9uZV8uos8pE5tohg0tz8PqLOMbJavEtgVwCTHRlv/44xDXJXQ2FXf/9XLfbaZ6MCi
 s7y7evwEsT78TWz/OpUIZvCLkDFwIykDy2EDAZDl0EHoCIbKQ2V07iEnbV1QICrv7qx3EVl+
 FW4IhMcqdIlrY6Z5qqFovPWZBrN3PAFXKbtXMb6srUrvQub+/QlkLcEfmE9bRegFaARUcsUx
 2Goyq5Pr2pkHsrDFqjh+PdrU3M/gyKmnpF2BVINHf0IW7GM+MUWn2s1nfDYKsxDarpLyQPtX
 VavFr4Pz2Lu6jPCeTIj3U6IikysBzrjtgyTz2cwWybHwtb9n1AAU7C2AR0XRC+1IQpitzjJO
 gP0td3xsKBz7UcsM2Wiusje8QnpcL5RAcD7I8SRZCcuo1dCxpA4RtW12IASMd68JsoBtnR/Z
 eHZ8GSlj2lKpKIN1O+8qomFv+7aG3WtlfjQpryNzSpZynEQuVA598DmM/DF/dqRRPq0kW0WS
 m0s3mmJFw7wobvdoVcOPEWN20qeg40GMOZS2nwg313n7uwuKD4q3D1XDZ2IJ/YLpDSpfSDx3
 U7aedU8EC+XzzpQGFvxV1h+Aqk1nmzq7orFknLZ+ltgQYcVFQSviBV3Bp85KUsF7FkR3zpFF
 AkGcxeAC7+0Q0/iKMMIWFMCZhKOwLWhMv5smxIshOryuKmKPbY0DrFoVL4VlgOUmVlHBp8a+
 bYTRr5xYR4V9aLaoBTjF5myWvHnkXQqMvjmCste8M0fqz4j+lPmHFz/ttEasupd0cDSJcsmK
 dDWsctx7llq/2sKfy1J2l1kig+hFPobr6bl68Tat5yh7qCvUrwsTqMZ7UtRZSw2gp3ujVQku
 dyS2f1bT9ifhI3/+RpMI3eivIfczgk6LOsFMYWwe7h8sX4AImJNQhBGdcrTcPQ67yJ3ZX/e7
 lxLGMIMbPscPczQiUZRi0bzX6pU+NadEVidQdQWFYhg/y/8zzY79oE5W+Dr5WqtJJzR2FpKO
 utKkCRmkN+R7PhQ2/fZDzIbpGWIcxUgiD3X0IGDUryjmIfEgMGRTV4NGTQ6FptQNCbXsxLyX
 fK7zd3oSl/Gs5S13814LR/MACXhxuxAu6JIW4askw3D1yNFXsDwjvOR6Z+37XdP80dAG8B15
 AHEH6NWOtN6Pw75n4+lXBo0Ciz6ccDSPh0g3Yjejv8L+Pl7PlDiaJUzJhMC1qK87HteVAx1T
 7Dq+F2eWKodacBnR/XNsn1Oods7bfBQegHA+Nqz/m0AoUtTYkdhcLIqqz1GakTC1BZYXar5o
 v9IiwcRV8J4pV4ZGW+0PzF27D7GWKJJyaiJXaVOtGrMCPVTDwMxYnktJnH9kI9jcLaog/1d5
 2ZPnycn5eMvzyQjXhy3/yvlu6MK3zskvrC+rjQI/3JfHYD822/FD0tOyPMSgOISEXHnvBaxa
 XkKdory6ZFjJML95c8k4n8lZg4kcTFAVuOlQXKV7evAEsmUvdRQiQTY8t3JdqO2JDMOO64Vz
 RPlWmg71wnVhhFz92UXBD6n6ZV3Qef1cdZgzS2uF2/BcV8K6a4cq8r9u2kAS+4uYE9gymFug
 YCXAzcAT8vVFyMpnxApPC9aJYlb50ZQRMxKyn6Y+7NL9QYObHLIH5S5r8POyNzQ1yB1TM82l
 DuN4PLawMp3jDs8y4k8qyeKvD56nwPwV85qH2i104ZU0+vlYPux9OsATdk/oFxAePsDNNSzv
 263049tQUir2vIVGF/raYfrI5/fUiG4WSudWO+RdHOLkSp/OUn3t0HAEw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XPDEVa8mnQyrCE7QrJVuk+DiI+orL9Y04lQ7vn2ZhyYlFPBw8P
 re/8jztCWVtN5yMEtLpTnkAsS9qBznmqKdjbN8AV7mZniDhILKFuBfBPXZsl/d8kTFn4Y36U
 4jSdkaNDSaNzZHZKjBkW6F+q4bsaC6zJw=
X-Talos-CUID: 9a23:YniPCmOMqlhAvu5DWitG6VwXNsEZKWz74Vj5B2OfFEx5cejA
X-Talos-MUID: 9a23:6VU2XQVsyCXFZ1jq/G71lWEhNoBB2LzwEhktl7cjheC/BBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194166053"
X-MGA-submission: =?us-ascii?q?MDFQkN+EFfnoFaFHsWI3oFLVzFxnnTT272RGwK?=
 =?us-ascii?q?9fCrBCCx0jY3Uyq9a/pdGGFZvGtoK+Wci4X6+8/P4IUcJ1Ivt7Qtzmcf?=
 =?us-ascii?q?jytEaUiOxSMq83L2iazXneOzBLOchgX7DUpCFLwaikWZ/oCPwLBROGZO?=
 =?us-ascii?q?gD8DIy0gvSFdLLmlHWq7YZKg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 22:26:52 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id CCEDA2064AE4;
	Fri, 15 Nov 2024 13:26:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCEDA2064AE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706005;
	bh=C//qZdfJfhN40N7nu/AQ5wmq+hj+onzvFzX2KrlsiOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HJAgH8LJ0t02ke9L/fBSseVg4mPwyzRUYKkcIBNh0PXg4ks/yx3FEqq7Ab8V80mCx
	 twfijyV8trWsX1EHtCAISl/otYzpQq+n69SN9Jzv1KZ/q2FjsSm6OPzwLcdwZ6tTZp
	 t/rVqrGYFsKA1powLrxYtcm95fdENEeogYK2qDWs=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-21-911fb7595e79@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jack Wang <jinpu.wang@cloud.ionos.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Louis Peens <louis.peens@corigine.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org, 
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, 
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com, 
 linuxppc-dev@lists.ozlabs.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 21/21] nfp: Convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2048
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-21-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 6e0929af0f725b2b3855c69bbe894e6626c566b3..6925ad985fc9e2d5641feea41ff277107a8dee9c 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2779,7 +2779,7 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
 		break;
 	}
 
-	netdev->watchdog_timeo = msecs_to_jiffies(5 * 1000);
+	netdev->watchdog_timeo = secs_to_jiffies(5);
 
 	/* MTU range: 68 - hw-specific max */
 	netdev->min_mtu = ETH_MIN_MTU;

-- 
2.34.1

