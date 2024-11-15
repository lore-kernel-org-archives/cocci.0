Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BA2D68BDB
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DTjXQ8JEnxKHPkRfiey8gv8xkSCkh1L+oMakOx6bumQ=;
  b=OXouKH9lM8OXfUa3UFAQXRXJEckdEI3HsObJfy04MPOG2T6XEZ3/yxIg
   yxujPpabD7+FIca6l5lWXtVLOGcNxRzdULKwEnnYfzZRkci4xM12phADL
   NVAoxeGqAZMvdeaqueqoqYdGYZNKIrcmCqS4Th7Ycdik6d4CGKAigAJQU
   4=;
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
   d="scan'208";a="194170098"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B75AFE0F16; Fri, 15 Nov 2024 23:36:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 20BC3E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:51 +0100 (CET)
IronPort-SDR: 6737bc9a_gp/V7W34tMdMS+6PCXzIYJa+lwmxbPv5QiRcD/QIcZg4Wvx
 3ZGMP/wKjjFIXJ6kPDZcQOrsndEPNrK8yACWn+g==
X-IPAS-Result: =?us-ascii?q?A0EgAABHuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8lAiYCAkYQBgESgwGCZQYCn00Bh2ABAQKLI4EygQGCDAEBBoJn2?=
 =?us-ascii?q?TiBZAmBGi4BiEsBgWyDfTuDQnonG4FJRIEVNYMzhApOg0aCaYJFhRMlhQaDe?=
 =?us-ascii?q?Zl+CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bIQtcg?=
 =?us-ascii?q?SmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCTmQyH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefBEaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZSKoV?=
 =?us-ascii?q?IIYOoFcRgcjFYMiTwMZD44hg3qPPgG2HkM1OwIHCwEBAwmFRgEBiVs0gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:VDKXWxSVWRuGDiJwzQd1BnQ/CtpsonKIAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSBMOBt7kd17ae8/i5HzBbudDZ6DFKWacPfiFGoP1VpTBoONSCB0z/IayiRA0BN
 +MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj5ZuJrwvxhbGrXdEZutbyGx1Ll6Xgxrw+9288ZFt/ihMof4t69JMXaDndKkkU
 LJUCygrPG8y6MD3rxfPSheB6GUBWWsMiBpIBAbF7BD+Xpjvtybxq/Rw1iqHM8DoVL44QTut4
 btlRx/ukycHKiU28HrLhcxqjaJUuwyuqhpiyIPJeo6VNf5+fqTAfdMGQGdKQ8hcWzBdDo66c
 oACFPQKM/pGoIbhplsOtRq+CheqBOPz0T9Dm3v60bQn3+g9DQ3K2QotFM8MvnvJttX4LKccX
 +6owqbH0TrNYPBY2Tn/54bWbB0vpuqBXa5yfMfL1UUiDR/Jg1eWpIf4Pz2VzOMNs22D4uRvT
 +2vkGAmpBtrojOyxMkjkJPJhoMVyl/e7yV22oA1LsC/RUFle9GkEIFftzubN4t2WMwvWGVou
 Cc8yr0btp+3Zi0KyJU7yB7FbPyHaI+I4hz/VOqLPTh4g3dldau5ih2v/keu1vfyWdOo0FZWs
 CVFiN/Mu2gC2RHN6sWKS/tz81m91DuB2A3e6+BJLV42mKfaNZIt36I8m5Udv0nAAiL7nFj7g
 ayVe0g6+uam5PjqbLv6qpGcMYJ/lwLwMrw2l8CiD+k0KAoDUmqB9eih1LDu8lf1TKhJg/Eoi
 qXUv4zWKd4fq6KkGQNZz5sv5wilAzqi1NkVm2QMIUxBeBKalIjpJ0/BIOrlA/e+glWjji9my
 v7AM7b8GJvCNGLDn63kfbtl605T1g4zzddH6pJQC7EBJu/zW0DruNzdDx82Lxa0w+H8CNV62
 IMeRXiDDbOeMKPXqVOI5+QvLPeQZIINpTrwJeIp6vzsgHMjhFMQfaak0YEKZH27APhqO0CZb
 mDtgtcFH2cKpA0+TOnyhVKcSzFTZ2y9X7g95jE7Eo2rFoPDRoGrgLyc0ya3BJhWZmFaBVCWF
 nfobIKEW/kQaC6IPsBhlTkEWaCnS4A6zR6urhP1y6J7LurI/S0VrYzv2MBv5+LPjREy6SB0D
 8OF3mGJVW51kHkHRzsy3K1koE19y1KD3rNig/NCD9BT5vVJUh07NZHG1eB6BcryVhrbftiVU
 FamXsmmATYpQ90txN8Bf1pyG9S5gxDY3yuqBqcVmKaRCJw19KLcxXnxKNxnx3bIzqlyx2UhF
 /NGP2mhzohy9hLaT6fYjl6e3/KyfK4Y2wbL+XuNzG6SsVseVxR/B+GNf3cNfUbY5ffw6kfPR
 KSvCvxzMQJNzcOJAq1HdtPoiUlLXrHkItuIJyr7t26uBBrA/fXESYvuf2gHlm2JBEEangU78
 X+YOA06ASm95WTTEGoqXX/1Ykik3fR7oWG2Ugdgwg2XakRz2qad9RkSiviRDfgU2+RA8AUoq
 Ch+VHW81NPQENmB715iYa9VSdAw+lFK0STerQMretSYJqdmgRY3eQlxvgu6zxx9B4NBudIno
 HMj0Ex5LqfOlBt6djaf29jQPafSI2+6qBCocavN8lLTytCb/uEI8vtu7x3BoQWoHwIG+mpu1
 90dh1mB4pTDSi4bTpv1Vm428QJ7rvfUeH95r6XV3npoOLL8ijbG2sJhUO0kwRGkdswZKKqAF
 R/aEsgTCI6gMrpu03SgaBMJOKh3/aU3d5eqfv2H1aqDLuFmhS+ry2Nd79Y5mmKF8Ch9Q+iA7
 ZYYyveXll+HXjD+jV6n9NL3hIlCahkdG2O+zW7vA4sHIuVIeowGE3vmAcSt1NB/hNa5QXlS+
 US/QVEPwt2seBm6YUbw0EtezxJT6Ua6gjC1yzg8sDAvoeLL2C3I3vTKfQACPm9NWXkkik3jZ
 5W32ZRSfEWpbA9hvxK//lr3wbMT8KR0JkHXQEFVb273JWQkWay14P7KXcdU6Zc5+QpQSu69Y
 hjORbnnix8b1T7zWWpUwXYwcDT8/t3QmxFqgWSRIWw7g33Ddcx921+L7dPbX/Jc0yQuQCh+l
 CmRB1K5edKu+IPQ37zDqOGlS2OoUNV5djPt0ZmJuSS2/yU+Cxqlmeypk9DoHBIS1S79ysksV
 C/N6h37Z9+vn5+kPOQvRUJoAlL478cyTppgn40rrJUR32UKwJSf+DwMlmKldZ1816PkJFAMW
 SIMxZaB5wLkxFFkKFqJzojwUHzby8o3I5Gdbm4akg005cpDGe/A67NNlyF8s3K7oBjXbPw7m
 S0Sn79mzGMRivpBlAdl6yyHCbATVR1cICfljFKE4tW3tq5XZU6ud6S90Ax1mtX3SPm+ogZZU
 W2xWpomGTRs9Ft6eAbQ0Hr245qieNTUackPrBqRuxPBifVFbpM3ivcOwyFgPDS59Ucix/Q6g
 hsm45CkvcDTMWJh5qO2BVhGNyP0T8IV5jzpy61Zm5DSl6WmF499FzNDeJLuTvKvCikO/aDiP
 g+UDDA67HOSH7nfGhWE9G9irnTSA9aqMW2aID8SytA0AFG4LVxehQ1cZjQil4Q1XlSv3s35e
 V11zjMc/Fj1rl1L0O0+c1HDUmDarRzgWDYxTZWFKRNQ6EkW+1XUNMmT9Od6GSdw5YC6oUqBJ
 zrfLyhBE2AFEmWFHVTiM/H67Nja9+mVCsKxKvLPZfOFrukIE7+zxJeo1IIuwTuQKsiVdi15D
 vg83ENrU35mH8CfkDVZD2Q1mjjKYsjTqBr00Cpttdz3pPbmQgXi44eFI7RVNtpr9la9hqLVc
 6aoni9nJDtenrAFwX7Hyb4S0VITw3V2dDCpELsBsyPAQKP4lahQABoWLSh0MZ0Mp5k81whJN
 MjXwvj137h0xqouC15EUVHnlummYssFJ2z7P1TCUgLDHbKKPzDUi+XqZ6X0HbRWgP9ZqF62t
 CqXHlHLOimFkX/iV0brecNFiSyAdCdbsZuhOkJvAG3uV5T9bxShLPd9lzo/zbYzgzXBMmtKd
 XBQckhO5p6d6yVVjuQ3T2BA5XkjLuSCnSuV/sHSMJEfvfBsB2J/kOcMpDxw6bJQ4ToMabpX3
 mP4qcJypFSin/jFgm5FWR9DsXBhg56XukBmNLTx1pBGQnvCxBsX8WOdEQ8KpsMjAdrq7eQYg
 P3Gjr7yLn9htZrs8NcRHdPZLojPZH8oKwboHnjMARcIVyWmM0nYnUVWlPzU/XqQ+NxykJ/jl
 YBGcrZGHHkyEPWbQhB/G9MPOtFvVy4Mmr+Hls8Yo3G5qU+VDOdXuIuPf+KYBvinfD+Jh75JT
 xgF27X1KcIfNdu/k29rbl131LrDH02YCdNTqylmRgw5ukNA9D55VGJlnwrHZw2jqF0UFfivm
 Rh+3gl8ZuQr7zDqy1Q6PFzHoG03ikZn3Z3OiCyYdD/3ZIK5R4BQAjG840M4Lpr/QgAzaASon
 EptLx/NXbcXhLxlIyQjoQnQo5ZQUdtbV7FDZldEzPKPYt0s0FJBumCpwlJB6eLZCJxk0gwwf
 sjo51BJ0AErU9czKuSEJqtP1kUWmauIsQej0ucszEkfIEAK6yWZfyte/AQtP6MtKi7g3uto9
 QmLnT0LLG0FTfEnptpq8UchPu2GyWTnybEVbgiTMOyWKeu5tmTKmNSHCgcy0UMBkQ9F8LR83
 N0sW0WRXkErirCWEkJNfe7fKBMdRtdd6WPPem6QtuOF7Z9zI5f1QuT1TP3IuKsSnlCMEwMgH
 oBK5cMESN3k/1vVIo/ENrkMyVAN7R73IVyDRKBGYh+Ekzcvp8C50Y952pRbKjgBAGJ7dyKt6
 eCT7iEuh+CCVdF+TH4bWIYAMnN+DMO+nDRYtnIGAjC21O8dzAmq5SX7ryjbCzy6ZN1mMrPcX
 xp9QPOr+H1r6aqriHbd6JLXK2r9MJJpvdqZrashrJGbF7t+V7B7v0ra091DTWajVWLCF/a/P
 Z/5Z4IraJr/DXPsFhSVkTU8Q8z2OZ6sKLSFmwfhQc5XvZOd0TRrL8KjFzwBUxNxvP1LsKh3Y
 EgAboA9bBqtuQkzO6a2KwTd1tS1X06nMzxfQ/JYyKOxYLkBi2Icb/KwzzMET9lu3+iq+0oMb
 IsHghHX2bCoYIwIFWDSHm1UMynVtC08kHYpYuc+2PY4xRTWmVYZOjGPMudubToA9/M7HlPaG
 XJ3D2A/SkKSxd7B+gmt2roV8gNeksxS3OkDt2Lx6NuXQjO2WeSIro7UtSNoOdonoKpqGY/uO
 M2LsNXZhDOJCNH1sxeCSyqzCbJwl95dO2oMRfNFn2w+EdcboocH4lhnEo8GKqBVQIwor7yna
 nIwFSsWxCMUVKubwScPxOy73u2e3jWXfdwGOQMevZNJj5NJUSl7JCcXu7WuUY7bv3WJRmgCP
 EEY6gEaoEoin5V3ZeTs/sLrXYRBzzce9+p5SCbbPoFl7VbrDGqE1xywdPyimvep3Epz0/vtm
 o0HWQF2CGBG2v1b0EAvLeczY40NtYfR+gSUfEj69DbpjvC6LVJR4dXZcVLlEJDCs2vsFCERr
 zlcf5JU03zbEdwxkgx2IPIvpVNRMMOrZkD3+T06741zGr25U927gVE/ojAbRHHuW/FBEeB9r
 FPeXnVKZp2qrpj/c8FZQnVR44GcolEfn0BgMii007JTLshM5ngHWz0Z5X25u8azU4V71MJwF
 NdYJtBiumy7AK5JPoO5qHosu7PuzHKf8Dc55hPy4TS4G6a1S6p0+2kTAAAgISzKr1EiJ+Yo9
 mrI91nL9FF4ue5GUPzHq0R6oDF5F4sGPjdG2nGjZwB1VHhJvORcAKvQes1YBfI1YEnrczc+D
 /89w0uR/Uw8uXrjZD064gBa4SHGQw4sVSRThrr3niw2odqoIzgHU9RFcGNlJwHMNQ+Wn2hx9
 CxWbAk+XZkHD9tD07IWx41Z+ozFU0n6bWkgVRBiPxwx17Jkj09FsVuRYinbRV6tfPrDozVzf
 MGMvIioJvG/9wBC3NDJquc9oogKXGKvg0WNSMrfr4bmv9vC4kaHdK7iMu21SXvASiXcyxWxj
 q0jFJ7E427YNw8NeMoy8mYtfZW0UT2DBh9BPa9OYhMDDciSCP1Dq+FePIp/fboRvLRqHlSBT
 w/uH4qmqL9HKEzSTHLQNXbJ6fSx9KTU67GVUu38foqU3X+STqt3N4176TDTH7bszJ8Y/0v9w
 PB28U1mD1PBNnPJt8zvczsC/9LqbU7+ptssFDLSDo13lS/gz0FJbcsXSgWu8ZIF2NVc6X3qT
 vl/3FS1u+pXpPF/8Ydi27ly0o+vILvKb/RXtUgyGh+PGgBj7YkgGkB7RmZMcqkUKfzLer8eg
 9yooOfyf0AOwDuS/eERKd7OJkWa39K6FinZUhtc2gEItT8dKAKYkf+Dga59D8i/96D/3Qo27
 l6yIwRjrvgl7JqY+qeOuO7cbgfAhbkCVK/wQ8rvr7Mq80qM7PwgnbQKdyR7eQqiWOQaU8ccw
 C/nw8VIhWohGsPKBbPg8dZHVnQkjnTlmptnGE4RFO9SFr2OvMxfkmo+h+3FJ4gOaKkR/wTHX
 RWgE7IE1Tuq837Oey863VeXjk22GDPpvzqU5WdiTCDBzsnuiB9QX7izXgJJWjaxfFR/qHWJN
 Rbps9z+veI06ls3OyrqroHo9iPpNbVJEsn4PNHZLzMzoQddgZQxT8au2YkzHdu7PcdX9XB1d
 PzF7G231SRGpu0U4uiWqtHQ4fjREXS62ueXorWE3jFYw1A8vFci+palN/rU4MaNTeju3GEUB
 XQa2UOJT1u+rbrVqEoRMEqA3RLQmYAECdpe2GExykDs4OVLrMsbzAxFDc6AYvoDoWu2Iz7o2
 ROEZMpxUCCC0jxRF1azEF9iGaF61nii9M7OkH7R/RUvSOwSPwTqjBx+FYQ4IGop6V4K0mwGE
 AMXbgucAq3uDkPgZYcJTkkMbx2b0aPyI/xxghI1m+7zoraDN6R1HM9vfr5FgxSLnURHF55eq
 qAYTL9mOhdc+KPRugn+Gt3iVvnim2A3MK79ScRb/MYF8no6t1/kAUX/r84es/BC2MrbE8wMK
 YLBt8198Up9sDsGdygWxQN6kwv8SucE4ubq/tnctpOsrOeoTqckAesNpH1WTyxziYX9hFc7r
 JTZzeBZH8fYgIT26gFNKlaOuYDHw195KOEULJmscqom/HICbXt7RTpGLZ+NZv8w7jU4ejja5
 1VYA8MFTdcZOtfd3wVVgVfuQ7Zd6ozQHVrSWOIRP4g4qmHwzj4y6541VO3tvSS3KZ7o5FZIJ
 /pfjS9omYGKtK0PzPHVEiRS/WiBZk0/3HaZ05fUQaWVn63E2JTOWlgBBCJzT4pNOG/I51m8X
 uTs3JTxDlHNsYms39RnKR7WHyzr1OEMtqIGeQJZoh3yxSMWVoX8hvbO9sGp9HMSrVpfVoB68
 RzCHqxbeJR9IxXx0MexFABwAS72ececcRRL2qLe3uAX/+B3LFfzf6cfIxQZ2/T/6HFPSRBpR
 qKwtVGcFe4cf9ppTvrYo2sdsNkmdPBJZQXB4sW69H9BszVUSEcxZaU1ryBGe0WGhwBTV6vu+
 fYBhgYaTd9lqBpMFGa3ayo14zvKU7gQjbHEUadTrWrVF/FSFRw4aHAbIVv9wphldrq3kOoSt
 2pHmng4u/02y3l9QwP6vyTwpqUL0DZm+beitTxHt2YWK4fW2yrOF1hHy+wHyKkGDHO3o1G1Y
 HAZbYv7yL1mI9nws4wg6G44ehItY2sNWuHqWESSx+uYR5eCtt5RnkvHoMLVcbq6NjQfLJw5y
 BT+Vz540wPEmw1v/ndNSTKlpoxBRs31KYMuwSymHnLefVAH7/ZSscf/glUMSfM/dVJrxGgwm
 tjCXCAGQ9bDXnoklgVxI3sRa4pNsFVJcstgyibNpKRN+RsYJSvZApjwsJeFht/GgDE8VYs4n
 zmQ+fLD3852liQ1wZsx5yqK8hz6lsTcUslxEj7214xFzvf5aenruecCGtIOIFuJVP4EL9nl/
 Gq9wpJxXUG5gL8ZGgjgWAfm7rPaVTq1D2iZUv6MaG+Cg3AyNUugvXGV
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:1ugJoqwAzX1UL8MkU08DKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: 9a23:veL9XW8DCewwVeH07r6Vv0UVNcoKU0f78FPRAWjgGyE2Ubq/Y1DFrQ==
X-Talos-MUID: 9a23:Yj/ekgqtl9pV4FIQQGMezxJHb+BZvK6eMlIUiLUm5OOuOQdRISjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771138"
X-MGA-submission: =?us-ascii?q?MDHIpqfU6ym5/mVlkNhN0gcxb5UsA/e4u834zp?=
 =?us-ascii?q?bdmMcobzYpCqJO5Ea6rF9BYN6+HbD7/MpC246K0ILYFdYUNmTJapWAXH?=
 =?us-ascii?q?iVNHJ7bYw3OT8VXCPFWaIAy4y/PXEyRvyRxekhGLkrePWcyDV0eKvwCP?=
 =?us-ascii?q?04sLWIYcSGRRp3UVDIqUlDjw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:51 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id A9C08238AF4D;
	Fri, 15 Nov 2024 13:26:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9C08238AF4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706004;
	bh=DTjXQ8JEnxKHPkRfiey8gv8xkSCkh1L+oMakOx6bumQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oGb2YPV5HdUkrLc8aXXGxz7j6fdC94ISGz/3Z3JDkeGMzqfQOdm/os+DxRfbZJSZm
	 Sm8lyg5zbYiuzLJMaRkj7E/23RBdauVbVu8dNvl0Gp3UJGc2WZ7231aTsociCQa1Qd
	 Z6HMNGoW3/gYR/l/pPCt55x0CtSvKcJxm9RO1wp8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-16-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 16/21] Bluetooth: MGMT: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2044
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-16-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a429661b676a83ec2d34ed7e228195f39a153f9f..ca89c26d04ec64869e6b99de099d343f4c548ce5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -209,7 +209,7 @@ static const u16 mgmt_untrusted_events[] = {
 	MGMT_EV_EXP_FEATURE_CHANGED,
 };
 
-#define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
+#define CACHE_TIMEOUT	secs_to_jiffies(2)
 
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"

-- 
2.34.1

