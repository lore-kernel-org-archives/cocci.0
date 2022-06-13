Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A65BC43334
	for <cocci@archiver.kernel.org>; Mon, 13 Jun 2022 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=DhYRo2THaGx5qQkWP7orIkpOxtb9Au8nk54qOg5bwjA=;
  b=Qc+t/1ZsO6Hv+lIc8ZUbquXMJMxb5CEIGzEOH+pjTUoi51XpJZNIrIsz
   o4hBxCSLfqMNrG1iMvRVkx/34b8MzHz+Qt1O0x7HaBe8GIJCFbdldgwyz
   Fppj0sgAVRq0nEgBSYSVnW2f4b3ourYiifNU57SsdX9yrObYMU+wT1nCS
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.91,296,1647298800"; 
   d="scan'208";a="40660832"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2022 09:14:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D8143E0152; Mon, 13 Jun 2022 09:14:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D473E0038
	for <cocci@sympa.inria.fr>; Mon, 13 Jun 2022 09:13:45 +0200 (CEST)
IronPort-SDR: O73lAelhbofDvVloF2sdS2je77T/Gt7jebSeXT/JLGNiiUa9iKBGBBg1OIQ1cjAquN3RfX71Gl
 hXGSVOQ4mvvlUnpLgJj1S4poipsVpfOk3F1qahZkP9Fbt547zjDwH1yRLMkEqKhV7iXbKPG6Vd
 6kU7aJltioZvReCa6ImDpaBxZya04InO1WbaKDfK7qC/9Mm/UxCp1xZFJjwqMs9bV6sB8heC7Y
 bkjqWqFwnprsU7tfOH+qf84HMezRlwBQImfZLMWQ3FLJCEFskyRNJ3H+Bee7Rv9m7o1qtlbeRh
 Pv6ZI9zuB4zL7tLvZnA8gMJ0
X-IPAS-Result: =?us-ascii?q?A0CKAgB/4qZih/AAcso+HB4BAQsSDIIEC4IkgQFVLwcIR?=
 =?us-ascii?q?JQRAQEGgUKLGhAPhmOJbAZdgXwCCQEDAQsBATcIAQIEAQGFAoVJAh4GAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQ0LCQUICgcQA?=
 =?us-ascii?q?wsFPGRogU+BdAs0DYI1KQGEHAFGMFI8ARKCfQGCZQMwAhBFri6BAYNlQYJ/D?=
 =?us-ascii?q?VEJDV6BB4E9hhyDNYVFgRmBEIFLgzKCIEIDgSaGdASNRosjAwkEBwViEoEGG?=
 =?us-ascii?q?3EBCAYGBwgCBTIGAgwYFAQCExJNBgsSAhIMCgYWDg40EhkMDwMSAxEBBwILE?=
 =?us-ascii?q?ggVLAgDAgMIAwIDIwsCAxcJBwoDHQgKHBIQFAIEEx4LCAMZHywJAgQOA0UIC?=
 =?us-ascii?q?woDEQQDExgLFggQBAYDCS8NKAsDBQ8NAQYDBgIFBQEDIAMUAwUnBwMhBwsmD?=
 =?us-ascii?q?Q0EIx0DAwUmAwICGwcCAgMCBhcGAgIZJy8KJg0IBAgEGAQdJBAFAgcxBQQvA?=
 =?us-ascii?q?h4EBQYRCQIWAgYEBQIEBBYCAhIIAggnGwcWNhkBBV0GCwkhFgYpEQUGFgMNF?=
 =?us-ascii?q?kwnBQdBDyk1NjwvIRsKTygdmhVhLSoBAReDNgEBkUEIgwSNHp1QagEGAg2DQ?=
 =?us-ascii?q?4l+gSCGf4d4hWMaMYVEkRmRfgGWayCJQIEXgjaDWpFehCUCBAIEBQIWgWGCF?=
 =?us-ascii?q?YJegUoJRQECAQINAQICAwECAQIJAQECjjaFF4ktNzECATgCBgsBAQMJhUUBA?=
 =?us-ascii?q?QEBiRiCSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ye+DxqiQiFsKOvoq1l7bU+AcX161QxYKZh0ujC45NGQN5FlHY01je
 htvDDrUb/jcNmH8KNF2PNy+pBwP6pGAm9A1TARuryo3FHtjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8x6TSFK1nV4
 4mq/ZSFYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Npln4ewFSI2eaj2u/keSUdoNA5gPq5N9+qSSZS/mZT7I0zuc2b337NjAFxwNotwFuRfWzkUs
 6VBdHZVKErf34paw5rjIgVorsgxKZiyFIMCoW0mwD3ES/0gKXzGa/yUuIEEhmdg7ixINan+V
 /BFdWNCVRLjQSxPBHExM6wZzM790xETdBUC8AjJ+/JfD3Lo5Ad227PsGMHEf8SDA8RThEeR4
 Gzcl0z9Cw4TMNi32zuA+GilwO7JhyLyHowIfIBU7dZqnUaPgGEfFVsdUzNXvMVVlGaUQNIDD
 lNT/xANsKsoqnyMYcf+XBa39SvsUgEnZ/JcFOgz6Qeow6XS4hqECmVsctKnQIJ23CPRbWJ7v
 mJlj+8FFhQ06ODFGCr1GqO89GruY3ZFdQfucAddFVNt3jX1nG0kpjnpJjqJOJGojtTzcd0c6
 xCXpiU/74j/YOYLyr6nu13LnnSnoPAlrzLZBC2JBwpJDSsgOuZJgrBED3CAtJ6sy67CETG8U
 IAswZT20Qz3JcjleNaxaOsMBqq1wP2OLSfRh1Vid7F4qWnwoyPzI9sLuW4lTKuMDiriUWKyC
 KM0kV4NjKK/wFP3NcebnqroVJ11l/K6SbwJqNiNNIoSPPCdizNrDAk0PRTMgTiFfLkEmqE+P
 57TfMqxBn8GCKNhhDOwS68H3KQmzzo1xSvVSIzkyA6kmbGTYmKYU9843KimM4gEAFe/iFyNq
 b53bpPUoz0GCb2WSnSJreY7cA5bRVBmVcGeg5EGLYarf1s2cEl/UaK56e16IeRNwf8K/tokC
 1nmBye0PnKk2SaYQehLA1g/AI7SsWFX9itnZXV2Yw7xihDOo++Htc8iSnf+RpF/nMQL8BK+Z
 6BtlxyoDqsdRzLZ1S4aaJWh/oVueA7y3FCOIjG5JjUzYthrQVWRqNPjewLu8ggIDza27Jdv/
 ef/i1mDGZdTFR5/CMv2ae60yw/jt3Yqnu8vDVDDJcNeeRmx/YUzc37xg/Y7LtsiMxLGwjfGh
 Q+aDQ1B/LvNvpQpttTFmOaPqd7xQed5G0NbGUjd7Kq3bHWLoDD8nNUYCOvRJGLTTmL5/qmmd
 N559fCkPa1VhktOvqp9D61vkfA06ezpquII1Q9jBnjKMwmmB748cHmL2c5D6v9EyrND4FLkW
 l+U5p9XNajPM8W8SAwdIw8sb+Ki0/AIm2COvKpvfxigvHd6rOidTEFfHxiQkygBfrF7B4Uon
 LU6s8kM5g3j1xcnboScgiZP+zjeJ3AMSfx+5JEHG5OthwY2jFpEOMSOBijz6ZCJStNNLkhzf
 m7K3vWf3ewEyxqQaWc3GFjMwfFZ2cYEtidMwQJQPF+OgNfE2qI60RA5He7bleiJIsirEt6fO
 1SH82V1OL6SuTpkmY5IWQhA3ilfUQaB9BWZJ0QhzQXko4uADwQh71HR/c6N4VsFtW9QY35Q+
 tl0DU77BC3ycpiZMjQaACZYRj+KcTC13g3fg9zhEsiYWZI8CdYgbmlCekJQwyba7QgNaIEra
 AWkECucqUE2CMLIn5AGNg==
IronPort-HdrOrdr: A9a23:zGNmFaxn9+gLn9oKhlzWKrPwLb1zdoMgy1knxilNoNJuHvBw8P
 re/sjzuiWbtN98YhsdcLO7Scq9qA3nlKKdiLN5VdyftWLd11dAQrsO0aLShxLNMxe73tJh9O
 NdSYREYeeAaGSS9fyb3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,296,1647298800"; 
   d="scan'208";a="16564288"
X-MGA-submission: =?us-ascii?q?MDEb4VM/gTvNDt4rLao+MdvT8OkmPkV2jbD/sP?=
 =?us-ascii?q?ahik20PFX+L7geP+6Tjuif4Zf5xnGI0xHlF+TCZzHNMvMqTwKYIk7k7f?=
 =?us-ascii?q?x0UU/iYNdtnmzyC7A1PNvmytCzLJpTGVZ35rg1hQ0WGRUuM354bQrAdN?=
 =?us-ascii?q?bAr5ERQBONenVDmTsJF3z8Zg=3D=3D?=
Received: from hust.edu.cn ([202.114.0.240])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 09:13:44 +0200
Received: from localhost.localdomain ([172.16.0.254])
	(user=dzm91@hust.edu.cn mech=LOGIN bits=0)
	by mx1.hust.edu.cn  with ESMTP id 25D7Cm7g023904-25D7Cm7j023904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 13 Jun 2022 15:12:53 +0800
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Dongliang Mu <mudongliangabcd@gmail.com>, cocci@inria.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2022 15:12:42 +0800
Message-Id: <20220613071243.12961-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] dev-tools: fix one invalid url
Reply-To: Dongliang Mu <dzm91@hust.edu.cn>
X-Loop: cocci@inria.fr
X-Sequence: 437
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/20220613071243.12961-1-dzm91%40hust.edu.cn>

From: Dongliang Mu <mudongliangabcd@gmail.com>

Fix the invalid url about Semantic Patch Language

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 9c454de5a7f7..d9976069ed12 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -66,7 +66,7 @@ The wiki documentation always refers to the linux-next version of the script.
 
 For Semantic Patch Language(SmPL) grammar documentation refer to:
 
-http://coccinelle.lip6.fr/documentation.php
+https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html
 
 Using Coccinelle on the Linux kernel
 ------------------------------------
-- 
2.25.1

