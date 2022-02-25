Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D672C433FE
	for <cocci@archiver.kernel.org>; Fri, 25 Feb 2022 16:36:16 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,136,1643670000"; 
   d="scan'208";a="23269529"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2022 17:36:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09226E0380; Fri, 25 Feb 2022 17:36:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8D94FE0380
	for <cocci@sympa.inria.fr>; Fri, 25 Feb 2022 17:36:11 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=avarab@gmail.com; spf=Pass smtp.mailfrom=avarab@gmail.com; spf=None smtp.helo=postmaster@mail-ej1-f41.google.com
IronPort-SDR: aTfq1RBLg1hwgpk7RrfkhULNE3Ub09m2147PcikMbVuZexKgxVg1oj9OTYZoAzhawKQI7r6z1L
 uZjg4pcIX0G5IFZOjqfN/HfbYZYw5ZV4tnZgVnnhSDSyUFP9dSBEDRBa9Y6Wm+v2BJpQX+/ezB
 cwjDk5R9FbkToLAB8ngAvLp9aNFRSXxKDaNRcuph3sdTbNcx+XhauP7z2yqJKtKIrCWt5OiRZw
 LBn4zYhNTJ/9+sUOU/QsaWjtdgEr0zaGIUwWmWTiyexUqSENUEPFIwPSmrfsQlPrMS3zirmACP
 q6lxo3V5gwjsxSGxceaqZVuo
X-IPAS-Result: =?us-ascii?q?A0BJAgBsBBlifynaVdFaHgEBCxIMQIFPC4IoflcrBE8Dh?=
 =?us-ascii?q?FGJBogRA4wnkDMUgWgLAQMBCwEBNwgCBAEBhQcChA4CHQcBBDIHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQ0LCQcICgIFDg4FYAFhAwFEg?=
 =?us-ascii?q?U+BdAsDMQ2CNSkBg2MBAQEBAgESER0BGx0BAwELBgULDQICERUCAhATEQEFA?=
 =?us-ascii?q?QEbBhMigmOCZAEDDSEPoieBBD2KOHqBFQUXgQGCCQaBQAGDCAoZKA1qOoEeA?=
 =?us-ascii?q?gEGCQEIEW0sigeDQ3onHIINgUuCdD6Dfkc/glmCZQSUN1oIICsvGyROdwwNQ?=
 =?us-ascii?q?R49lRGWMZRPX4INZosGlROWNZFkllGBJ4trmTkCCgcGECMSgTIBgg5NIxVsg?=
 =?us-ascii?q?jhOAQIBAQENAQIBAQMBAgECCQEBAo4dDBYVgzuFFIVLQDQCAQEBMwIGAQoBA?=
 =?us-ascii?q?QMJgjqDCiYTCwGNBAEB?=
IronPort-PHdr: A9a23:A7HT7hVkgHRXUykB9lQn/VgyXNnV8KxKXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9+duq4P2rKempujcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffRtEiCC5bL59I
 xm7qRndvdQKjIV/Lao81gHHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2Q
 rJeDDQ9LmA6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD+/9
 KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe84RS2hcUcZLTyFPAp2yY
 ZYBAeoPM+lXrYrzqFQSohWxHgSsGPrvxyVUinPqx6A30eIsGhzG0gw6GNIOtWzZqczrNKgIS
 +C+0bXFzS/Fb/NY2zfl7pLIahA8qvyRX7J/a9DRyUw1GAPeiVWQr5HuMjSP2eQTqWeb9fBvW
 vm0hm4orgF+uDmvxsM2hobVgYIVz0nJ+CNky4k6OdO2UlR0YcK4EJROrSGaMZN7Tt8jTmx1t
 ig3y6EKtIK1ciUOx5kqyR7SZv2JfoWU/B/uVfudLSl3iX94er+ymhm//Eeix+DzWce531RHo
 jRbn9TKq3sD2RvT6s2dRft8+EeswTWP2B7J6uFCP080kbDXK5k7wr4/kJcYrEfNHjfulUnok
 KObcl8o9+uo5uj9fLnqu5yRO5V7hw3jKqgihMOyDf4lPgUAQWSX4/mw2KP/8UHjXblHjfk7n
 6/Eu57AP8sbvLS2AwpN34Yj9Rm/CzCm3cwdnXYdLVJFfAuLgJbrO13TOfz4A/iyj0m2nDdkw
 PDGObLhApHTIXTZjLjherN951ZdyAo1099f+4pZBq8dLP/3QEP8t9zVAgUnPwCpwOvrEtpw2
 p4GVWKKGKCZMafSsVGS5uIoJumBfJUauCjnJPg//fHhlmQ0mVAYfaaz3JsXbGq0EehhI0Wce
 XbshMwOHn8QvgUiVOzqlEGCUTlLanqsR648/C00CJq6DYffQYCgmLiB0z21H5JMYmBGDkuBE
 Hbpd4WBQPgMcjidLtVgkjwCT7ihSpUu2QugtA/g07ZnNPbb+jUEtZL/09h4//HclRYu+jNoD
 sSQyHqNTmFxnmMQXTA6xqF/oUpnyleCy6d0mfJYFcYAr89OByU9NZfayeFhQ+v5WgPHctqNS
 VDuFvehATg3SN8qheQFY0d7F9imjxbr0C+6RbMYwe+lHpsxpwzC1mK5Dtx7xXRYzjFppVsvW
 M5GLmqgzvp26QHJDoThnECQlqLsfqMZin2evFyfxHaD6RkLGDV7Vr/ICDVGPhO+RbXR40rDS
 +TrErE7Kk5aztbELKJWa9rvhFEARfH5Od2YbXji03yoC0OuwbWBJJHvZ31bxD/UXUEamhoa9
 16JMAE/AmGqpGeNRCd2GwfXalj3ufJ7tGv9S0Y1yw+QaEg03qS84BcfrfOZQvIXmLkDvXRps
 C16SXC62d+eEN+cv0xhcaFbNMs6+0tC3HnFuhZVO5WhK+VvhAdbfVgu+Uzp0BpzB8NLls1CQ
 GoC6g10JOrY1VpAc2jdxpXsIvjMLXG0+hmzaqnQ01WY0dCM+65J5u5q41Pk9BqkEEYv6RAFm
 5Fczmec65PWDQETTYO5U0A58AJ/rq3bZS917p3d1HllO625+jHY3NdhCOwgwxemN9BRVcHMX
 AbsGtcTDeChLeUrnx6iaRdFdOFe+agoPt+3IuOc0f3jN+JhkTS6yGVftdolgwTcqmwmE76Og
 89WppPQlhGKXDr9klq758X+mIQfICoXAnL60i/8QohYeqx1e48PT2aoOcy+gNtk1PuPEzZV8
 kCuA1Qe1YqnYx2XOhb0wwRK3E4/rnmumC/+xDtx2WJMzOLXzGnVzuLueQBScGdVTXNrh3/jJ
 IG1i5YRW03iPEA50RCi40j93a1Soq9yenLSTUl/dC/zN2h+U6G0u9JueuZ34Ygz+WVSWeW4O
 hWBT6Ll5gAdy2XlFndfwzYyc3ervI/4llp0kjDVIHF2pXvfMcZ+oHWXrNXCTORY1BIJQSB5j
 X/cAV30M9Sy/NqSnovOqajkDzPnBsAVK3C7i9/Z/CKgrXVnGxi+g+y+lriFWUAh3Cn32sMrH
 STEoRDgY5X6gqGzMOZpZE5tVxf378t3HJ07k5Nl3slBnyhHwM/MrTxbyDSWU50Tw6/1YXsTS
 CRextfU5FOgw0h/NjeSwJq/UHyBw8xnbt38Y2UM2yt74doZbcXcpLFCgyZxpUK16AzLZv0o1
 D4DwOEn4lYVhugIvEwmySDXUdVwVQFIeDfhkRiF9YX0pbtefm+lWbe13Ut629umCfvR6hEZU
 3H/dJA4GCZ25cgqK1PA3kr47YT8ccXRZ9Ye5Xj221/QyvJYI5Urmr8WlDJqbCjj6GY9xbdx3
 lR+mIu3t4+dJyBx8bKlV1RGYybtaZp2mHmljL4CzJ3Lmdn+RtM7RmpNBNyyEbqpCG5A66ihb
 V3VVmRi8jHDXuOOVQ6HtBU48TSWS8rtbzfPYyNBqLcqDBiFeB4B3kZOAGR8zsZ/TkfwnITga
 BsruWpXvwK+80oWjLovbkm3U3+D9lj0LG5uFd7HakIRt18nhQ+dMNTCvLsrT2cBocLn/ErVb
 TbCLwVQUTNQBRfCXgG/eOHovZ6ZraCZHrbsdaOfJ+XT77UEB7HQgsvwt+kutzeUapfVZyckU
 q19gxsZGyg+QpWRmi1TGXZOyWSXNJ/d/036omou/4ip+fDvEmoD/KOpDL1feZVq8hGy2uKYM
 vKIwT1+MXBe348NwnnBzP4e2kQTgmdgbWvlF7NIriPLQK/K/80fRxcGdyN+MtdJ5KMgz0FMP
 8DckNb8yr9/iLY8FV5EUVXrnszha9YNJimxM1bOBUDDM7rjR3WD28bsfaa1UqFdls1Rvhy0/
 DuZSgrtYm3FmD7uWBSid+pLiWDTPRBTvp28bgc4CWXnS4GDCFXzO9t2gDsqhLws0ymSZChMb
 H4mKhML8uTDiEEQyu9yEGFA8Hd/eOyNmiLCqvLdNo5TqvxzRCJ9i+Nd5n0+jbpT9iBNAvJvy
 06w5pZjpU+rlu6Xx39pSh1L/3xCmouRtE9KNqDQ950GUnHBtkFojy3YG1ERqt1pB8e68bhX0
 cTKnbnvJS1q9tvV+Y4RBZGRJp7ednUmNhXtFXjfCw5PHlvJfSnPwkdalv+V7HicqJM3/4Ptl
 JQ5QbheTFUpF/keByyN8/QNJZ52WnUvlrvJ1abgAFKxqRDQQINRuZWVDpp64N3qITedyLRGP
 l4Gneq+IoMUOYn2nUdlbwsi9Lk=
IronPort-Data: A9a23:yw9g0qjuw2zwv++DekEM7qrGX161phYKZh0ujC45NGQN5FlHY01je
 htvWW7XPPeDajfwKN9yaYqx90gP6JOEyd4xTFRs/n82QiljpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq+ZeCYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplrJC5cy04G/L1gssjYiVpOWJAMa1I5+qSSZS/mZT7I0zudnLtx7BjDhhzM9FBvOlwBm5K+
 LoTLzVlghKr3brnhuLmDLM11oJ/daEHP6tH0p1k5TjHBOwvS7jMRqzL4ZlT2zJYasVmQ6ePP
 ZVEOFKDajzqQC1SHQ03EahvxqD5tH3xSCBjqWCa8P9fD2/7lVQtitABKuH9ftWVTMFRtlSZo
 2jc9iL4BAsbPZqR01Kt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgfVF/+rPvgz0DiApRQL
 Esb/idopq83nKC2cjXjdwS0qUSurztDYsB/LdwG2SvO9KbU7RnMUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9GSL1GlC8/WPaBMQFEYMRTXRbElZdsrEPtKl2302fFI8yeEKgpoStQWmY/
 tyckMQpa1wuYSMj0qy6+RXKgWvpqMSQCAEy4QrTUySu6QYRiG+Zi26AuQSzARVodt7xory9U
 J4sxZT2AAcmU8zlqcB1aL9RdIxFHt7cWNEmvXZhHoM66xOm8GO5cIZb7VlWfRk1b5lYIWC2O
 ROI4mu9AaO/2lP6PcebhKrhW6wXIVTISLwJq9iINIMVOsEpHON51Hg3PBPAt4wSrKTcufhnZ
 c3znTeEAnEdBqBqpAdatM9MuYLHMhsWnDuJLbiil0rP+ePHPBa9EO5ZWHPTML1RxP7b+G39r
 ocHX+PXmk43eLCvMkH/r9VIRXhUdihTOHwDg5YIHgJ1ClE2Rj9J5j646e9JRrGJaIwOzraYp
 izmAxQAoLc97FWeQTi3hrlYQOuHdf5CQbgTZETA5H6khCouZ5iB9qAae8dldLUr7r0xwvt9T
 v1DcMKFW6wdRjPC8jUbTJ/8sI0yLETx1VzSZ3KoMGolYpptZw3V4du7LAbi8S85CCDo58Yzp
 ruX0BzWHMgYTAN4AceKM/+ilgvjvXUUlO9ocVHPJ91fJBfl/IRwen7+i/Y2J4cHLhCanmmW0
 AOfABE5o+jRot9toIOZ2/zc94rwSrlwBEtXGWXf/I2aDyiC8zrx25JEXcaJYSvZCzH59aCkU
 uNfkKPxPfgBq1BV6tYuHrtuy5U+0NvhvbptyAppQSfQZFOxB7I8e3SL0JUdtqBJwbMF6wK6V
 ljVoYtfMLSNfc7nSRsfeFNjYeOE2vUZ3DLV6K1tckn94SZ2+puBUFlTb0bQ0n0DdOMtPdN32
 /olte4X9xe71kggPOGAg30G7G+LNHEBD/gqu81IGoPtkQZ3mFhObYaGUX3z6ZCLLthOawwkf
 mbSi63FiLBRgEHFdiNrR3TK2ONcg7UIuQxLnABefQXXwoKdi69lxgBV/BQ2Uh9RkkdN3dV1N
 zU5LEZyP6iPo2plicUrs7pAwO2d6MB1O3AdymflUEXcRkisE2HPdSgzZb/L80ce/GZRODNc+
 dl0DYojvSnCJKnMMukaACaJaMAPifR+8wTDnIasGMHt81wSf2/+mqH3DYYXg0KPPC7y7XErY
 cFl+e9xbevwMit4T2jXzWWF/ex4dS1o71CujR2sEG3l0I0clPyPNeCyFn2M
IronPort-HdrOrdr: A9a23:sjtSIK8VMb4jBEN3k81uk+Fvdb1zdoMgy1knxilNoENuE/Bwxv
 rBoB1E73DJYW4qKQ0dcdDpAtjmfZquz+8L3WB3B8bsYOCGghrlEGgG1+vfKlLbalbDHmA279
 YbT0ETMqyUMbEYt7e13ODbKadc/DDvysnB7o2yowYPPGNXgspbnmFE43OgYzVLrX59dOME/f
 Snl656jgvlXU5SQtWwB3EDUeSGjcbMjojabRkPAANiwBWSjBuzgYSKUiSw71M7aXdi0L0i+W
 /Kn0jS/aO4qcy2zRfayiv684lWot380dFObfb8yvT9aw+cyTpAVr4RHoFqjwpF5N1HL2xa1+
 Ukli1QffibLUmhOF1d7yGdgjUImwxelUMKgWXo8EcL5/aJHA7Tz6F69Nhkmtyz0Tt6gDg06t
 M640uJ85VQFh/OhyL7+pzBUAxrjFO9pT44nfcUlGE3a/pUVFZ9l/1XwKpuKuZJIMs60vFSLM
 B+SMXHoPpGe1KTaH7U+mFp3dy3R3w2WhOLWFILtMCZ2yVf2CkR9TpU+OUP2nMbsJ4tQZhN4O
 rJdqxuibFVV8cTKaZwHv0IT8e7AnHEBRjMLGWRK1L6E7xvAQOGl7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P1njDMWftac7hCwlgF/NKggF5vsulaSR4IeMN4YDGRfzPWwTrw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,136,1643670000"; 
   d="scan'208";a="6992759"
X-MGA-submission: =?us-ascii?q?MDFFHWVfQDIJ4Nz6dQ1z/UP9c1T4gPIqI2TfrK?=
 =?us-ascii?q?Tbasti8mWOG9jfc060tdoIhoHxf4DCSRe8ucRw+dJzD7yiTkNe6XOCCu?=
 =?us-ascii?q?0boiq3dgf4MBlSlY1n5pZDBhBQx2N/pye4jCRtNzDSnzefdZWUAagDTE?=
 =?us-ascii?q?VoIqkc6Fmz5t8of6ufj/9sjA=3D=3D?=
Received: from mail-ej1-f41.google.com ([209.85.218.41])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 17:36:10 +0100
Received: by mail-ej1-f41.google.com with SMTP id bg10so11967667ejb.4;
        Fri, 25 Feb 2022 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IwVzK3kw9gPzoeRpG403QF3M30obGGlZMg9wAqnRMrg=;
        b=CF7Q4lBwK6ltnggCK73MSS7nLsRp6McaFuQ0T8n3X4AgG86hPunSSduo1A1mGAK08r
         CT8eK66XsqH4kJmXdk8spgJQGHeSx5UnEIWbS+ajo4OkmjY8eGXj2OL0P4BSgKdRWSpw
         IIQmGuGEA5MmrN8hDgacgUrmDDdMVB/mRlhtQW18KK7jpwyfAKAhZcY0ByOyuhohP6n/
         sKmPoY2SZx5FbIsH7y8qXy8RF1i/RxcvPWSuUkKDKC1stvx42WHimOB13keiYM6Nb9t4
         O7ReQOSpagGzBcpOloAEgWuBb6Z7se0Qzq02Xkynipz64ZQMAlqfFsnsPUWvR0szxlSo
         y6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IwVzK3kw9gPzoeRpG403QF3M30obGGlZMg9wAqnRMrg=;
        b=AO6S+NLYb+OoJhURSAlAjW06nluLvkgAHl0RuTqeJulC4lIyrCQVS+MWS8Ttu7LHLv
         euaEm638poQfi4HdKUAdSJVlI/axT/3stdeFmLBEQNy4kXDTpX6mBo8Grs4XzghLfPDY
         jzFyuiFLL1W8ZnaCGh5+volAfNFcuyLdRYJwgdqx16r5Bqr4GziHPU2Nh0RpsiFJhypp
         oJPXO1DjycFFlpNyQXTvB5c4W0nRKwkABbNU8mdbCOxuCC7TOK+fK0PCRFr4RXWn8DrX
         QNhBEWevWNK/i1eemWDQwZGyKUkEYe0h8WuVoCg5H5x1uqHNeWIBwBuyijPZbTFYTwBs
         R3Cg==
X-Gm-Message-State: AOAM531k7AG6eKYJEXKFIBrTE6PO2Xg6IupTl5cHoM2FGXIoFIYwd6Rt
	+Tm4PNN6GtZpxlqPZ73E9D8=
X-Google-Smtp-Source: ABdhPJxcOA9TI5VVAoudqwcVizNk+3dhL5d6pUejwV5jATFpmBq2gvcebsfW61a8EEhPAvYwkhuXpw==
X-Received: by 2002:a17:906:cd17:b0:6ce:3727:65f2 with SMTP id oz23-20020a170906cd1700b006ce372765f2mr6837468ejb.720.1645806969535;
        Fri, 25 Feb 2022 08:36:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx1-20020a0564020b4100b00410f01a91f0sm1582441edb.73.2022.02.25.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:36:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1nNdZg-000eNT-Hw;
	Fri, 25 Feb 2022 17:36:08 +0100
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Julia Lawall <julia.lawall@inria.fr>, Abhradeep Chakraborty
 <chakrabortyabhradeep79@gmail.com>, git <git@vger.kernel.org>,
 cocci@inria.fr
Date: Fri, 25 Feb 2022 17:28:13 +0100
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
 <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com>
 <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet>
 <220222.867d9n83ir.gmgdl@evledraar.gmail.com>
 <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
 <nycvar.QRO.7.76.6.2202251601040.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202251601040.11118@tvgsbejvaqbjf.bet>
Message-ID: <220225.86v8x27vk7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH] add usage-strings ci check and amend remaining
 usage strings
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 154
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/220225.86v8x27vk7.gmgdl%40evledraar.gmail.com>


On Fri, Feb 25 2022, Johannes Schindelin wrote:

> Hi Julia,
>
> On Tue, 22 Feb 2022, Julia Lawall wrote:
>
>> [I]f there are some cases that are useful to do statically, with only
>> local information, then using Coccinelle could be useful to get the
>> problem out of the way once and for all.  Coccinelle doesn't support
>> much processing of strings directly, but you can always write some
>> python code to test the contents of a string and to create a new one.
>>
>> Let me know if you want to try this.  You can also check, eg the demo
>> demos/pythontococci.cocci to see how to create code in a python script a=
nd
>> then use it in a normal SmPL rule.
>>
>> If some context has to be taken into account and the context in the same
>> function, then that can also be done with Coccinelle, eg
>>
>> A
>> ...
>> B
>>
>> matches the case where after an A there is a B on all execution paths
>> (except perhaps those that end in an error exit) and
>>
>> A
>> ... when exists
>> B
>>
>> matches the case where there is a B sometime after executing A, even if
>> that does not always occur.
>>
>> If the context that you are interested in is in a called function or is =
in
>> the calling context, then Coccinelle might not be the ideal choice.
>> Coccinelle works on one function at a time, so to do anything
>> interprocedural, you have to do some hacks.
>
> Right. The code in question is not actually calling a function, but a
> macro, and passes a literal string to the macro that we would want to
> check statically.
>
> I did have my doubts that it would be easy with Coccinelle, but since =C3=
=86var
> seemed so confident, I tried it, struggled, and decided to follow up with
> you.
>
> Thank you for confirming my suspicion!
> Johannes

In case it's not clear from the upthread (and I thought my [1] explained
it well enough) I never thought it would be easy or even possible to do
this particular thing with coccinelle.

I.e. I mentioned in [1]:

    Aside: if we did want to do the "parse C" method the right way to do it
    would be to have a coccinelle script do it

So it's intended as a side-note to explain to a new contributor that
*if* we do end up wanting to parse or transform C we have coccinelle,
and it's a great tool for those cases where such static transformations
are easy. I and others have added some in-tree in the past where
appropriate.

But I then went on to say (and elaborated on later in [2]) that in this
case the right thing to do is runtime checking.

So, I'm sorry if you wasted time on it. In either case it seems we've
ended up in agreement in this case about appropriate uses of coccinelle.

I.e. it's a fantastic tool as a semantic patch engine, but it
understandably has limitations where you'd effectively need it to
execute your program to decide what to do, as is the case with the
parse_options() API and the eventual parse_options_check() etc. doing
assertions depending on flags that got passed down.

1. https://lore.kernel.org/git/220221.86tucsb4oy.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220222.867d9n83ir.gmgdl@evledraar.gmail.com/
