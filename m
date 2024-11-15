Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC39D68BDA
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Q64Lap8gGilYnZS8wBYuXVtg6CkDWFgIDR5hpRb/qKY=;
  b=SNIQdC/X91A7VnYYjvY4JmNWlFLVQ4Zlo2YzWgkpgncVKlFFT4Gq2fSw
   05Dp+oUgbG42Eb+TYACYtdu4GE5xIiVoYrdkFq0MiYwUeyxile8Bqn6l2
   eoWucBCZoUIeN02osSESPMT+V17W65dmz+M43hWjLew6qTyZHBwa66xSU
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169733"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54FA2E0D6B; Fri, 15 Nov 2024 23:35:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E1E8E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:43 +0100 (CET)
IronPort-SDR: 6737bc93_WueD78TEnqsbJYckG2x2MRMgiY/j7YfhVa2WFjEYy01qLkQ
 G0gdG2WjKOgIV+CjK8bCvyqd1PB1Ey6IjpyPK4g==
X-IPAS-Result: =?us-ascii?q?A0EgAADnuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?UEIMg2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BAR4CA?=
 =?us-ascii?q?QMREh0BATcBDyUCJgICRhAGARKDAYJlBgKfSwGHYAEBAosjgTKBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGISwGBbIN9O4NCeicbgUlEgRU1gzOEWINGgmmHWCWFBoN5m?=
 =?us-ascii?q?X4JP4EFHANZIREBVRMNCgsHBWNXPAMib2pTeiuBC4EXOkKBO4ETLxshC1yBK?=
 =?us-ascii?q?YEaFAYVBIEORj+CSmlLNwINAjaCJCRZgR2BMoUahGxnLwMDAwODPIJOZDIdQ?=
 =?us-ascii?q?AMLGA1IESw1Bg4bQwFuB58ERoM0gQ4odYEMk2eDa41CoWuEJKFdATKqTph3I?=
 =?us-ascii?q?qhUghg6gVxGByMVgyJPAxkPWIJoimGDeo8+AbYeQzU7AgcLAQEDCYVGAQGKD?=
 =?us-ascii?q?4FLAQE?=
IronPort-PHdr: A9a23:oxztPBXJdtoLrCT9WcKgIc09cJ/V8KwzQjF92vMcY1JmTK2v8tzYM
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
 vzaOLDqH4/DIWLZkLj7eLZw805cxxQ3zdBY/59UDrABIPTuWk7+rtDYCx45PBCuw+bgE9V90
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
 DuN4PLawMp3jDs8y4k8qyeKvD56nwnwV85qH2i104ZU0+vlYPux9OsATdk+oFxAePsDNNSzv
 263049tQUir2vIVGF/raYfrKZ/fUiG4WSudWO+RdHOLkSp/OUn3t0DAEw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HmYfh6EXVOH3Z+hypLqE0seALOsnbusQ8zAXPo5KOHpom6uj5q
 OTdZUgtSMd6l4qMk3I/OrsBEDuexzhHPJOjbX5eI3SODUO21HIEGgd1/qB/9SIIUSXndK1l5
 0QFpSWY+efMbEVt7ec3ODBKadY/OW6
X-Talos-CUID: 9a23:TYr8y2xzDH6Gh+AOP528BgUsFuUocCLC8EvrGFO3EyFoRKPNUgS5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3ARsTJPw2P+bATdj7amq4uAOxQTTUj0a20UWRdoJQ?=
 =?us-ascii?q?6g8CoDHZiHRSQtmyOe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194166012"
X-MGA-submission: =?us-ascii?q?MDHfDTXqPNIPrOO50eqyPi43HKewGyRMmyxCdd?=
 =?us-ascii?q?FELLbM4Qa1pWJTedthZjeYRHekQq7iNuFLi8cClxLTTmIG6eMBK32GxV?=
 =?us-ascii?q?CUzLhv7LI0awzOrHE96meueNFoMczLqqs0Hn7OotBffZNJey7Sp9oxdS?=
 =?us-ascii?q?c4qkqcMfWT2ZGwP1ICR1vOtA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 22:26:42 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 33C45206BCF3;
	Fri, 15 Nov 2024 13:26:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33C45206BCF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706001;
	bh=Q64Lap8gGilYnZS8wBYuXVtg6CkDWFgIDR5hpRb/qKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qqVpjOTpvUDnqKvyg0F7x8y5V/QTgKE0vrlMSYSCNCLw1VcBjI0/Vl0G6Q39TTHHt
	 DRDU50XbhfXe3YX2edjYJBIv3SoKO3DsasrlEzDNkcD4CPzZrQ2JNzKwdnMxBZK6Fj
	 EbvBkDXPncjur9W0Dtl4dgGCI1NPWNvWmxFYJQrY=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-1-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 01/21] netfilter: conntrack: Cleanup timeout
 definitions
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2027
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-1-911fb7595e79%40linux.microsoft.com>

None of the higher order definitions are used anymore, so remove
definitions for minutes, hours, and days timeouts. Convert the seconds
denominated timeouts to secs_to_jiffies()

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 net/netfilter/nf_conntrack_proto_sctp.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 4cc97f971264ed779434ab4597dd0162586b3736..6c95ac96fa42a39acafb5b88a7cf8898010e911c 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -39,20 +39,15 @@ static const char *const sctp_conntrack_names[] = {
 	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= "HEARTBEAT_SENT",
 };
 
-#define SECS  * HZ
-#define MINS  * 60 SECS
-#define HOURS * 60 MINS
-#define DAYS  * 24 HOURS
-
 static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
-	[SCTP_CONNTRACK_CLOSED]			= 10 SECS,
-	[SCTP_CONNTRACK_COOKIE_WAIT]		= 3 SECS,
-	[SCTP_CONNTRACK_COOKIE_ECHOED]		= 3 SECS,
-	[SCTP_CONNTRACK_ESTABLISHED]		= 210 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 3 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 3 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= 3 SECS,
-	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= 30 SECS,
+	[SCTP_CONNTRACK_CLOSED]			= secs_to_jiffies(10),
+	[SCTP_CONNTRACK_COOKIE_WAIT]		= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_COOKIE_ECHOED]		= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_ESTABLISHED]		= secs_to_jiffies(210),
+	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= secs_to_jiffies(3),
 };
 
 #define	SCTP_FLAG_HEARTBEAT_VTAG_FAILED	1

-- 
2.34.1

