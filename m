Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36381C433EF
	for <cocci@archiver.kernel.org>; Tue, 14 Jun 2022 06:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=nzmHxPI/Ak4t2zyT5ApWv2Ru79n30ykKrHe/vbwCr+o=;
  b=tthznDYoiI1dKBhz8qmLBvBOCfeM1CyV/I7+IWTa4GgNBuizDPuufDTP
   YqZiFJPbppAD9QQSqWLzy4GKi8fh0qssKrEh8VVbydATz7OvSJBmfRG+j
   UEe8OUmCehy3Jaijo1a8imKD2CHad2RgMCK1gOc+1u9JLl0GI8wrCh5Y8
   w=;
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
X-IronPort-AV: E=Sophos;i="5.91,299,1647298800"; 
   d="scan'208";a="40866107"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jun 2022 08:26:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40FE5E026B; Tue, 14 Jun 2022 08:26:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AEC51E0038
	for <cocci@sympa.inria.fr>; Tue, 14 Jun 2022 03:56:09 +0200 (CEST)
IronPort-SDR: W5PuW1PEKIELwRaMzrNhC6Cp/EaS/q3hE/cTqvDBICoLHhHYGxT+riDPp87Ry66p8Ou3zjeaOU
 DtR7VF6Utm+jaAp8XTmwXuIrc0q7Bnap6Se75mGGnVccPk35dwljxCmDc5HMYUhHsUarYD8nOi
 umq9b47WF+4eWrbzl3oxEB5C4mXdHUwnyqd/6y3D4i5JYWZiGp1vw3FawBpKXDDt3GziRFLiyb
 yFxPa5eWTnWlFn4+uz1iKz6z27WLXgJaaOOh8DtHNFVmq42ybp2vP2TVjDxjhw7wbeYBk2COBm
 26B39X2Mbn18R5iKKtjqM/0q
X-IPAS-Result: =?us-ascii?q?A0AzAAAz6qdie/AAcso+HBwBAgIBBwEUAQQEAYF8BwEMA?=
 =?us-ascii?q?YIjgQFVLwcIRIxvhyEBAQEGgUKLGhAPhmOJbAZdgXwCCQEDAQsBATcIAQIEA?=
 =?us-ascii?q?QGFAoVJAh4GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETA?=
 =?us-ascii?q?QEPCwkGBwoHEAMLBTxkaIFPgXQLNA2CNSkBhBELAUYwUjwBEoJ9AYJlAzACE?=
 =?us-ascii?q?EWtUDKBAYNlQYJ/DVEJDV6BB4E9AYYbgzWFRYEZgRCBS4MygiBCA4EmhlIiB?=
 =?us-ascii?q?I1Ei1IDCQQHBWISgQYbcQEIBgYHCAIFMgYCDBgUBAITEk0GCxICEgwKBhYOD?=
 =?us-ascii?q?jQSGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDFwkHCgMdCAocEhAUAgQTH?=
 =?us-ascii?q?gsIAxkfLAkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMFDw0BBgMGAgUFA?=
 =?us-ascii?q?QMgAxQDBScHAyEHCyYNDQQjHQMDBSYDAgIbBwICAwIGFwYCAhknLwomDQgEC?=
 =?us-ascii?q?AQYBB0kEAUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2GQEFX?=
 =?us-ascii?q?QYLCSEWBikRBQYWAw0WTCcFB0EPKTU2PC8hGwqBCSgdmjlhLSoBAYNNAQGRQ?=
 =?us-ascii?q?QiDBI0enVBqAQYCDYNDiX6BIIZ/h3iFYxoxhUSRGZF/h0yPHyCJQIEXgjaDW?=
 =?us-ascii?q?pFehCUCBAIEBQIWgWGCFYEfgT+BSglFAQIBAg0BAgIDAQIBAgkBAQKTTYktN?=
 =?us-ascii?q?zECATgCBgsBAQMJhUUBAQEBhmyCSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:f0dZrKzoPOGvmz5JVgB6t+cUwCrEfRIJ4+MujC+fZmUNrF6WrkUDx
 mdNWG/VOquNZjfwKI13bY62809SvMDUy9VqTQc4+FhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrdRbrJA24DjWVvT4
 Iiq+aUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhdz
 4Vkub6IcDwxEZLpxLRaQgZDEnFhaPguFL/veRBTsOST0lbaNXbg3rNlCinaP6VCorwxWDgSs
 6RecmxVBvyAr7reLLaTRvtp150LLNTwIMUStmwmxjex4fMOGM6dHvSbv4QwMDEYq/BeF8jiS
 5YjWDtIRR3RbEwfBm40Mcdr9AuvriOnKWEG8Dp5v5Ef6G/Yxw1Zy6noKNOTe9qQRMwTkFzwj
 mbP4G39BjkINdmV0zPD83S2h+aJkzmTZW4JPL2l7eIsjVGOgGcVYPELabelidW+2meyeepmE
 FQ7xQ9y/e8j61eqHsaoCnVUv0W4lhIbXtNRFcgz5weM1rfY7m6l6o4sEG8phDsO6p5eeNA66
 rOat4ixWGw+6NV5XVrEr+vO82PqUcQABTZaPUc5oR05D87Li6dbYvjncctjGajdYjHdOSz6z
 jHikcTTr7UOltJN2qmmu1vB695NmnQrZlNkjuk0djv7hu+cWGJDT9f0gbQ8xa0eRLt1tnHb4
 BA5dzG2tYji962lmi2XW/kqF7q0/fuDOzC0qQcxQsR4q2n1oS78JNo4DNRCyKFBb5lsldjBP
 RO7hO+tzMIKVJdXRfYoOt3rUZ52pUQePY2/CKqJBjaxXnSBXFXfpn0wPSZ8LkjmkEkqmOkyN
 YqQeNqtCnBSAKJrhCC7XOoUy7QrjiYz2XzUX5OzxBmhzbeEDEN5up9YWGZimtsRtfveyC2Mq
 4g3H5LTm313DbOiCgGKr997BQ1afBATWMGtw+QKJ7/rClQ8RQkJVaSLqZt/INMNokigvr2Tl
 p1LchMAlwWXaLyuAVniV02Pn5u1Askk8y9mZ3BwVbtqslB6CbuSAG4kX8NfVdEaGCZLlJaYl
 tEJJJeNBOphUDPC92hPZJXxttU7JhS2nh7IMia4JjM5JsYySwvM897iXw3u6ChXUnvp75Rj+
 eX421OJW4cHSiRjEN3SNKClwWS3sCVPg+l1RUbJfoRedRy0oohnIiD8lNEtJMQIJUmRzzeWz
 V/PUxcFvvWLroMottLP3PjWo4CsGup4P0xbA2iCsefob3aHpDL7zNYZAuiSfD3bWGflw4mYZ
 L1Yn6PmLfkKvFdWqI4gQbxl+qQzuon0rLhAwwU4QXjGYgj5Cr5kJXXaj8BDurcUn+1ZpBCqH
 E+D559RP+zRas/iFVcQIisjb/iCjK1FxGONsK5teEiqtjVq+LenUFlJO0XegiJqKrYoYpgux
 v0suZJL5gHj2AAmNM2K0nJd+2iWdyVSU7g8qtcXDJKtgQxykgNOZpnVCynX5pCTaowQYxdwf
 WLO3PLP1+ZG207PU3svDnyRj+BTspID5UJRx1gYKlXVx9fIi5fbBvGKHejbk+iU8vlG7w63E
 mh2LFEzKKmTuTxu7CSGd375ABlPXXV15WSoo2blVkWAJ6VraoAJBG0gIvrL8UwEtWlaFtSe1
 K/N037rCF4GY+mothbfmidZRzjLTcFq6kvPlN3hFMLt81zWp9b6qvfGWFfkYCcLzS/8aIMra
 AWqECtNhXXHCBMt
IronPort-HdrOrdr: A9a23:A5JQray6SdaIPJPgd/BbKrPwLb1zdoMgy1knxilNoNJuHvBw8P
 re/sjzuiWbtN98YhsdcLO7Scq9qA3nlKKdiLN5VdyftWLd11dAQrsO0aLShxLNMxe73tJh9O
 NdSYREYeeAaGSS9fyb3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,298,1647298800"; 
   d="scan'208";a="16659923"
X-MGA-submission: =?us-ascii?q?MDGivfjAoMh8AFvdpeqn64i19Rtzhgjel+3K/I?=
 =?us-ascii?q?LmSVPAuXdQeuP3frDp44FQoWwD3F5DJuTYSF/Ui6tR2v8mTyYQKo//VK?=
 =?us-ascii?q?Wtf93Z+raUbpxcdgNv1B/QyRxcTy4mT0SelRjg8EdHKFU8tQo0P1jB8U?=
 =?us-ascii?q?s4mz7Vhy04G00k7v3dky9WFw=3D=3D?=
Received: from hust.edu.cn ([202.114.0.240])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 03:56:08 +0200
Received: from localhost.localdomain ([172.16.0.254])
	(user=dzm91@hust.edu.cn mech=LOGIN bits=0)
	by mx1.hust.edu.cn  with ESMTP id 25E1tbuD014131-25E1tbuG014131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 Jun 2022 09:55:42 +0800
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>
Cc: mudongliang <mudongliangabcd@gmail.com>, cocci@inria.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2022 09:55:27 +0800
Message-Id: <20220614015527.82900-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2] dev-tools: modify SPL reference URL to actual
 SPL doc entry
Reply-To: Dongliang Mu <dzm91@hust.edu.cn>
X-Loop: cocci@inria.fr
X-Sequence: 444
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/20220614015527.82900-1-dzm91%40hust.edu.cn>

From: mudongliang <mudongliangabcd@gmail.com>

This patch modifies SPL reference URL from old Coccinelle documentation
(doc root) to actual SPL doc entry on new Coccinelle page.

Signed-off-by: mudongliang <mudongliangabcd@gmail.com>
---
v1->v2: modify the title and commit message according to Bagas Sanjaya
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
2.35.1

