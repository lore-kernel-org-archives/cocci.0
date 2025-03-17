Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B81C282EC
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 22:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=tI1x33tadot0jT0cjbUYonoQO+tDE+XnQRCBdp9KDhE=;
  b=XLIvFMelvgrja5jRwsK49pAY13AqyCUmOPZgm1jnavniqbYi/Q8m1sQ6
   JSnYKeWhQEOplJKD22NwbNS+mYApQb5dn1UEeowaWeQQoSRopcn4Mg3IN
   Pgc0t96/xTKQpksjxIG5enj4ohcKNCJWJJXzt60o4ODEmZo7lbZwoLh60
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="213356787"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2025 23:10:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EF55CE0260; Mon, 17 Mar 2025 23:10:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9E5D3E0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 23:10:49 +0100 (CET)
IronPort-SDR: 67d89de9_gEuWcja8GI6Mt4+nVS/RuhxdjPuPRLIMbNiHDECqU4I/IS0
 CMQbyodim7KpDu/RsRKjuJz5QachrP9jAJu6TAw==
X-IPAS-Result: =?us-ascii?q?A0GYAQC2nNhnjxf/11VagQmBUwKCQn1ZNAcISGGHRI4ik?=
 =?us-ascii?q?x6KeRSBag8BAwENMRMEAQEDAQOFAIshAh8GAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFDjuFew1JARABggA7ghYsDTd/A?=
 =?us-ascii?q?QcGAQE4UH+DAgGCZAeuFIE0gQGCDAEBBoEIgWDZOIFlCYFIhW2CYwGEfHCEd?=
 =?us-ascii?q?ycbgg2BFIE8g32CWS+GDSKGToEMhx+Ef4Q0hE2FM4JQIoxRSIEFHANZLAFVE?=
 =?us-ascii?q?w0KCwcFgWwDNQwLLhWBRUM3gkNpSToCDQI1ght8giiEToQ8hEGFUIIRggWJL?=
 =?us-ascii?q?IRkLVCBTR1AAwsYDUgRLDcUGwY+bgeiFgE6hEQ9UQGBfCxLkyCQBaMmgj+BZ?=
 =?us-ascii?q?oFjijWVMBozgUuED5FsDpMDmH6kS4RogWc6gVwzGggcFIMiCUYDGQ+OOoFSg?=
 =?us-ascii?q?kKCI4FJgjG0BEUyPAIHCwEBAwmJAIcca2ABAQ?=
IronPort-PHdr: A9a23:bC7SPxMO+XUDp+gIrRsl6nbhBxdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvq8r1AeCBNmDta0MotGVmp6jcFRD26rJiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhFiiSxbaluI
 Bmqogndq8YbjZdjJ6sz1xDEvmZGd+NKyGxnIl6egwzy6sCs8pB97i9eoegh98lOUaX7e6Q3U
 7lVByk4Pm42+cPmqwDNQROA6XUAXGoWlAFIAxXe4xHhQpjxqCr6ufFj1yScIMb7UKo7WTWm7
 6dsVR/olCIKPCM3/W3LlsB9ir9QrRS8rBJ93oHUepmYOvpgcK3Ac90URm1PUcleWSNdGY68c
 4gCAvAdMetCs4XxuV0Dpga+Cwm2A+PvzydFiGby3aIg3eQqDAPI0xI6H9IPtnTUo8j+OaAVU
 eCx1qbIwy7OYOlI1jfl5ojIdg4ureuRUr1uaMfcz1QkGAzZgFuKs4PlIy+V2foXs2id9+dtW
 +Gihmonpgx+rDWiydohhpTNi48Iy13J9yp3zYYpKdClSUN2Yd+pHIdUuiyaK4d4TN4uTW9ot
 isk17ELuZC1cS4Xw5ok3x7Sc/+KfoiS7h79SeqcIS10iGxldb+/nRq+70atx+vhXcSq1FZKs
 zFFksXSuXAXyhLT68mGReVl80u93zuEyhrd5fteIU8ukKrWM54hzaA0lpoUqUnDGyj2lUrvg
 K+Oakko5vGk6+P8bbn8vZ+cMpN0ihnkPqQ0m82/BuI4PRYUU2eG5+uwzLzj/UvnT7VWlvA7k
 anUvIrEKcgGpqO1GRFZ34Yj5hqlETur3swUnXwdI1JEfBKHgZLpO1bLIP3gCve/h06jkDlwy
 v/cILLhGpvNLnzdn7v7YLly9VZQyAwowt9H/ZJbFqkBIO7vWk/2rNHUEwc1MxaozOb/FNV9y
 oQeVHqTDa+eLKzdrV6I6/k0I+iMYY8VoCzyJ+Ik5/7ol385mEUScbOn3ZsNOziEGaFtJE6SY
 FLthM0AGCEEpFkQVuvv3XqGWDAbR3uoXqQzrmU8DIuoJY7OXo6pjfqN0XHoTdVtemlaBwXUQ
 j/TfIKeVqJUAMrzCspokzhfEKOkV5dkzha28gnz17tgKOPQvCwer5PqktZvtKXIjR9n0ztyA
 oyG1n2VCXlulzYPQzY49KlyuUJ5xxGP3PswmORWQORa/OgBSQImLdjZxu1+Bcr1X1fGet6HY
 F+rWtuiDHc9Q4F52McANn50AM7qlRXfx2yqDrsSwqSMH4Ax+7nA0mLZIsEhjm6ejOwmhR89R
 9dXc3e0gahysQTeb2LQu2OekaviNaEV3SqWsXyG0XLLp0ZAFgh5TaTCW3kbIErQt9XwoE3YH
 feoDvw8Pw1NxNTnSOMCY8D1jVhAWPboOcjPK2O3lWCqAB+Ux7SKJIP0cmQZ1S/ZBQAKiQcWt
 XqBMAE/AG+mrQe8RHRpEVvhS0rh6ed6pTW3Qw58zg2HaVFgy6vg4gQc1rSXT/Ie2K5BuT90+
 2gyRg/gmYiLVpza/FkEHu0Ue9427VZZ2HiMsgV8OsflNKV+nhsFdBwxuUry1hJxA4EGkM4wr
 XpswhAhTMDQmF5HaT6c2oj9f7PNLWyntherYqD+01zG3tKbvKsCoqdwuxD4sQelG1B3uXJj2
 td92naE6JHHSgYfG8GUMA5/511xoLfUZTM47oXf2Ch3MKW6hTTF3sogGOovzhvIk853CKqfD
 0eyFsQbA5PrM+k2gx2yaQpCOulO9akyNsfgdv2c2aftMvwy1D6hiG1G5sh63Cfuv2J7TufG9
 58I2/+c002LWn/wgUygvcb+hY1fLWFPWDDmlG6+WdMXPPY6dJ1DEWq0Jsyr2thyz4XgXXJV7
 h/GZRtO2cOkfwaTc02o2ARR0UoNpnn00SC8zjFyj3Qotv/PgWqUmrmkLkdafDQQFwwAxR/2L
 IO5js4XRh2tZgktz16+4FrigrNcvOJ5JnXSRkFBe273KXtjW+2+rOnnAYYH5ZU2vCFQSOn5b
 0qdT+u3pB8T3QvqEnNQwD19ezzg6d3p2gd3jm6QNiM5q37Qd+l5yA/R4NGaSfMbjV9kDGFoz
 DLQAFa7Jdyg+96ZwozCvu6JXGWkTpRPcCPvwNDIpG6h6GZtGxH6g+Grl4itD10hySGinYoPN
 22AvFPmb4Lszaj/Le93YhwiGgrn88QjUoBmztlg3ddJhylc38nLuyNdwSCpbLA5ker/dCZfF
 WNNmYeIplK4hQs7aSjVj4PhCCfHy5M4NYPhMjFMgitvtZgQWvXMq+IY+Ek96lug81CLaKAkz
 G1GmalysCZI0blO5Fplzz3BUOBLWxAGbGq1y0jOto3lyccfLGe3L+rq3RInz4r6XOPY+ggOA
 i6jKMp6EyEivJwiaxqJ2Xn3oOkIYfHoZMkI/l2RmhbE1K1OLY4p0+ENnWxhMH78unssz6g6i
 wZv1Ne0ptrPJ2Jo9aO/ShlWU1+9L9sU4S3ohL1Ck9y+2ofzW405QnAMVt3zSO6wVigAsvLqc
 QqDWDExsXaUH7PDEBTXuBog9SuSVcr2ajfNfxx7hZ1rX1GFKVZagRwIUTlyhZM/Gg2whYTgf
 Ep/+jEN9wv4px9LmapjMxjyVHuapR/9OmpyEsHCakALs0cYvBSwU4TW9O94EiBG84f0qQWML
 jfefAFUFSQSXVTCAVn/P76o7N2G8u6CB+P4IeGdBNfG4eFYSfqMwoqil4V8+DPZfMKLN3dKB
 vAj1E5OG3x0UZe8+X1HW2kMmiTBYtTO7g+74TFyp9uj/e7DXQWzoJPXU/5VO5N0/gyux72RM
 Oidwip0Y2U9tNtE1TrDz74R20QXgidlemy2ELgOgiXKSbrZhq5dCxNIIzM2LsZD6LgwmxVcI
 cOOwM2gzaZ217RmbjUNHUykgMyiYtYGZn2wJE+STljeL6yIfHXK252lMfr6EOMByrwI6Vvp4
 2bcSRKGXHzLliG1BUDyd7sV0WfBYUEY4MbnLl5sETaxFtu+M0/ha48l12U/k+ds3CGYbSlCb
 V0eOwtMtuPCtyoA26clQDwTsiI9f7vc3HrJp+jAdsRG6L0yXHUyzr4Gpi1nkN43pGlFXKInw
 iKK94w0+AH0yLGGmGA/CkgT8jhF1tDS4B4qfKzd8tMosZPs9R8V42GdTRgH9YMN4jLHsq1Ix
 NzC0q7+em4qGzP8+MxAQtCMcIeAOjw6NAbxXiTGCw0ICzKmZzi3ug==
IronPort-Data: A9a23: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
 E4bn1ew3l0=
IronPort-HdrOrdr: A9a23:Mr3k7K0PjOmYVxHvVlihpwqjBGskLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN93YgBZpTngAtj6fZq4z/Ea3WB/B8bHYOCLghrKEGgA1/qa/9SDIVyYygc178
 4JE5SWY+eAaGSS4/yKgjVQa+xQpuWvweSStsmb50tRbGhRCp1I3kNDOSjeOGhffjMDJbdRLv
 ah2vY=
X-Talos-CUID: 9a23:qVGVN270Oi1IM9eEz9ss3xMwHu8gcEHm3VjsIU6lMUh7SpHIcArF
X-Talos-MUID: =?us-ascii?q?9a23=3ACRh5uQ5wHthLUPi7OVir3v+YxoxT4Y21IXldqqw?=
 =?us-ascii?q?kkMrUKzVKBQa/pRa4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="111832362"
X-MGA-submission: =?us-ascii?q?MDH1On98Qn0z+UepA1/jnDq34B0cDSbTxo9wpl?=
 =?us-ascii?q?/kIqsewxqkIsgVD/OGSWmh0sC6ealkaUFkAPpkadtVkSNnQkinvdsaxg?=
 =?us-ascii?q?nlzZGqFRRC4YWbucW01BhmlmqerlbMiaXM4+0uzIpNqtXw6LNTcSJL8D?=
 =?us-ascii?q?U3Up8Rg3stLjiFKZXJ80bQ6w=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 23:10:49 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742249448; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J2g1DbrLLTp57MOAMWRQ1tAbQJG6R/Vzz0eRSIJY3CDHohvfySl+96s+zCrhxw/Y1+
    CRriLJzQCMF15Or8L2ocM1AlEd531pQYxD3ApghqWvaZcaZ+pZmf/6jmiCdAniDb1hj/
    zmJGgcwsd+oQpSWYAMlifWsala3brbyivc43xShYHLOoJphgd4OJHa0m9HRYiPlbhWp/
    Mu+bbnY1ycazOFjezzmNsVO9TfGqSWUzXtz97ARzYvbxpF/zhtdF6bjQImwL4j1l6niE
    575mqJC/4RHTbO6E8p/d8sggrJmt/5EWyEruqr4pSLY+Awxr4QDO3Pc67Qxhi1NaZoSN
    uY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742249448;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=tI1x33tadot0jT0cjbUYonoQO+tDE+XnQRCBdp9KDhE=;
    b=faE+ZyMRfOEMSc97FpR8rsXkeOzDUAgLRGq3efukKww6OITamoXl4yMaitwlerO/St
    uyX2MkEXKbD7kTA23bwAic/DYehWF+pPfksEeirD2zUwyXormq1Sw3e1bk0PkVBuk3eT
    7th7f9A+HQaIWg1tPEqFKUq9rgunmhU31nmrZSqODDEpT/cWKraoRXcQXJSj8NNry8Ns
    tj09vW3e5lkv3O5focNQEc4gwPJL8FfwN9W6W3PXQCgeu1wJfaU5SdFxVAYLMQfRxmvJ
    x56LVAQe1J4564lfGhl51s4DNo4cHRVJ4Cgy4VopEDy1GNGjhRq+kyCTgyut+wuPLV82
    uAcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742249448;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=tI1x33tadot0jT0cjbUYonoQO+tDE+XnQRCBdp9KDhE=;
    b=Iiss+1abNaF/iD8ZTAmB/vk01xRUve+y9BoR4GZ+a1h2ZtDsqGa/exMGXJGOx6DoXH
    Q9DCBt7qHihRiCo6Xi4XYoJyslZfRLDiR7VnfCW7qOVLMURQscLn9JX7+5ygXn3/UGYj
    DR53Hl/ttAslZgd1oDmCRbSTDzR+1sScVbF/crnAVGaditkFEFprL9M/V6vwuc2G2CHt
    pdL1l7jMuAXmjGL8LyVNB3sSRqi0Jg+H3/PSo40U9iqk3GoTzcZ91cmePkAKXa+Gbcjp
    tk/YTHh770BofMXxJamDwLZg/qJ49TBm/NKMGZ3Y4RHdoeGJmooPWEZZz0BBxBJXWgHt
    5/mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742249447;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=tI1x33tadot0jT0cjbUYonoQO+tDE+XnQRCBdp9KDhE=;
    b=tleqQpxwP4LUh6EoNLMl1q6UEuWSHNd50neRPKNe4fp5hKxD11H5lqxo7vq5iOdMmU
    AXhB6MiXigF1ZJX5YYCQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSVYjagMyZmkab3cQQk8ITYm/c/zHbXf6Nw2MS9"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12HMAlyC7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Mon, 17 Mar 2025 23:10:47 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Date: Mon, 17 Mar 2025 23:10:29 +0100
Message-ID: <20250317221044.25197-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Subject: [cocci] [PATCH v1] remove unused version files
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2593
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250317221044.25197-1-olaf%40aepfle.de>

The file scripts/genversion.sh is unused since commit ad7cfbe97
("Documentation build improvement.").

The file version.ml is unused since commit 3277ba7a1 ("Next Makefile").

The last user of CONFVERSION is removed, which makes
AC_COCCI_CONFVERSION obsolete.

Resolves coccinelle/coccinelle#121

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 .gitignore            |  1 -
 configure.ac          |  2 --
 scripts/genversion.sh | 11 -----------
 setup/cocci.m4        | 34 ----------------------------------
 version.ml.in         |  2 --
 5 files changed, 50 deletions(-)
 delete mode 100755 scripts/genversion.sh
 delete mode 100644 version.ml.in

diff --git a/.gitignore b/.gitignore
index ed2ecf88f..623370c8c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,7 +20,6 @@ scripts/spatch.byte
 *.swo
 *.swp
 .depend
-version.ml
 
 .flatpak-builder/
 _flatpak-build/
diff --git a/configure.ac b/configure.ac
index f0c585329..83273a07e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -14,7 +14,6 @@ AC_MSG_NOTICE([configuring coccinelle $COCCI_VERSION in $COCCI_SRCDIR])
 AM_INIT_AUTOMAKE
 
 AC_CONFIG_SRCDIR([cocci.ml])    dnl  this file must be present in our src directory
-AC_COCCI_CONFVERSION
 
 dnl  reminder that this configure depends on macros generated by aclocal
 AC_MSG_NOTICE([this configure program uses pkg-config m4 macros])
@@ -605,7 +604,6 @@ dnl
 
 AC_CONFIG_FILES([
   Makefile.config
-  version.ml
   commons/commands.ml
   globals/cocciconfig.ml globals/regexp.ml python/pycocci.ml
   ocaml/prepare_ocamlcocci.ml
diff --git a/scripts/genversion.sh b/scripts/genversion.sh
deleted file mode 100755
index b70b837db..000000000
--- a/scripts/genversion.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#! /bin/sh
-
-# fallback date (in RFC format)
-VERSION=`date "+%a, %d %b %Y %H:%M:%S %z"`
-
-# use the date information from git, if git is present
-if test -d ".git" && which git &>/dev/null; then
-VERSION=`git log -1 --date-order --date=rfc --pretty="format:%cd"`
-fi
-
-echo "let version_date = \"$VERSION\""
diff --git a/setup/cocci.m4 b/setup/cocci.m4
index 88fce3a05..d4dbb0ad4 100644
--- a/setup/cocci.m4
+++ b/setup/cocci.m4
@@ -205,40 +205,6 @@ AC_DEFUN([AC_COCCI_PYVER],
 ])
 
 
-dnl  determine version date (RTC format)
-AC_DEFUN([AC_COCCI_CONFVERSION],
-[dnl
-  AC_SUBST([CONFVERSION])
-  AC_MSG_NOTICE([determining version suffix])
-
-  AS_IF([test -z "$CONFVERSION" -a -d "./.git"],
-  [dnl  git administration found
-    AC_MSG_NOTICE([building a version from a git repository])
-    AC_PATH_TOOL([GIT],[git])
-    AS_IF([test -n "$GIT"],
-    [dnl  ask git
-      CONFVERSION=`$GIT log -1 --date-order --date=rfc --pretty="format:%cd"`
-    ])
-  ])
-
-  AS_IF([test -z "$CONFVERSION"],
-  [dnl  otherwise, take the current date
-    AC_PATH_TOOL([DATE],[date])
-    AS_IF([test -n "$DATE"],
-    [dnl
-      CONFVERSION=`$DATE "+%a, %d %b %Y %H:%M:%S %z"`
-    ])
-  ])
-
-  AS_IF([test -z "$CONFVERSION"],
-  [dnl  fallback
-    CONFVERSION=unknown
-  ])
-
-  AC_MSG_NOTICE([version suffix set to $CONFVERSION])
-])
-
-
 dnl  find a tool, with specialized macros for certain cases
 dnl  $1: name of the variable
 dnl  $2: name of the tool
diff --git a/version.ml.in b/version.ml.in
deleted file mode 100644
index a5969ce20..000000000
--- a/version.ml.in
+++ /dev/null
@@ -1,2 +0,0 @@
-let version_date = "@CONFVERSION@"
-let configure_flags = "@CONFIGURE_FLAGS@"

base-commit: cca22217d1b4316224e80a18d0b08dd351234497
