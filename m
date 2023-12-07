Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F2DC4167B
	for <cocci@archiver.kernel.org>; Thu,  7 Dec 2023 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=C/w/ipWvpq4E6LyFuB2kfdu5NMXpzTEB+tOpUY/aogk=;
  b=RwzOFkrS5jG+fIqNVIhJtbcIlWHuY5TmMZPDoLApxdLMnBqni/+QpG0w
   3JyMvB+DhK2qi0mJl6DiXbHJR/lrfUC/Gd2Emxtb6alsICDGJPhQhhsFo
   O8QGOE4FwVHzZ/S2Y+VJW1i3V6AoV4t956+a7ZnCrhc8A99NQNcNd9myt
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,256,1695679200"; 
   d="scan'208";a="140926559"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Dec 2023 16:10:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 978EBE5E17; Thu,  7 Dec 2023 16:10:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B60EE5A3F;
	Thu,  7 Dec 2023 16:10:46 +0100 (CET)
IronPort-SDR: 6571e061_lZh3RNjBiONGpH5eEeSlBQG28bj2QcSsDybYhGVnNbAfoDM
 Hx6kX+N7Q9N7OBHEfuwv9KYh71SPo9l1raKhDnw==
X-IPAS-Result: =?us-ascii?q?A0HqHgAW4HFlewwR49RaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?U8Cgjd+UzAEC0iBTgGDBJE1hGuBVYVfh0qIb4MWPg8BAwENFAEHJQECBAEBA?=
 =?us-ascii?q?wQNgX6Ca4c2Ah4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBJBgGDgoBBSeFaA2CVRiBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHa?=
 =?us-ascii?q?x0BAREnNAImAmAJCwEBgnyCKgEDMQetfIEygQGCCQEBBoJmrHAfLCJWgWAJg?=
 =?us-ascii?q?RouAYdzGgEFY4RxhFwPgVVEgTyCUoV/gw6CaINnjQ+PEX4FQnAbAwcDfw8rB?=
 =?us-ascii?q?wQwIgYJFC0jBlEEKCEJExI+BIMyCn8/Dw4Rgj4rNjYZSIJbFQw1SnUQKgQUF?=
 =?us-ascii?q?2gpbhsSHjcREgUSDQMIdB0CMjwDBQMEMwoSDQshBVYDRQZJCwMCGgUDAwSBM?=
 =?us-ascii?q?wUNHgIQLCcDAxJJAhAUAzsDAwYDCzEDMFVEDE8Dbh82CTwLBAwfAhseDScjA?=
 =?us-ascii?q?ixCAxEFEgIWAyQWBDQRCQsoAy8GOAITDAYGCV4mBw8JBCcDCAQDLy4DFAMZK?=
 =?us-ascii?q?x1AAgELbT01CQsbBj4CvEWQWaB/NAeCM4FfBYFbDIhzljIGEy+DbgGTNA4Gk?=
 =?us-ascii?q?k+YQiCicIVIgXkkgVwzGiSDNk8DGQ+SS49HQDU7AgcLAQEDCYVGAQGDWoFAA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:fGeXx67k+pwcvqM/+gPXwOrXdLJyesId70hD6qkDc3xom6uj5q
 eTdZUgpHvJYVMqM03I9uruBEDtewK/yXcX2+cs1NWZMDUO0VHAROxfBODZsljd8kPFh41g/J
 tBN45jFdb3EV92tsri5hKkeuxQuOVvvJrIuQ/EpU0dKz2ChpsQljuQgWugeHFLeA==
X-Talos-CUID: 9a23:NPcS/m96r4dKIGWhY0+Vv00VQdA4YmKH9i/7GUu7OX9lbeWEVVDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A8KRbgg43e6MzC7rVk6jG99lDxoxU2YXzFF8Jzak?=
 =?us-ascii?q?JvvGAawJxMBTBrhSoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,256,1695679200"; 
   d="scan'208";a="73731901"
X-MGA-submission: =?us-ascii?q?MDFdUGOI/bn10JUp6OkDlWut94s7cYzldMTUrl?=
 =?us-ascii?q?UzYVENgd5M/g8FjuI7hUY/kEPI6gK/ZjsieqcbJJVW0ni4QZmF0ViAkY?=
 =?us-ascii?q?GUoHAvYDJpShcYlG9uifn2jw5ay/l1q5MxGDbnBa+t9uSYV0B6yE+3nt?=
 =?us-ascii?q?zaeJdQd+CtYKfMUieCZOJPCw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 16:10:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701961824; x=1702566624; i=markus.elfring@web.de;
	bh=C/w/ipWvpq4E6LyFuB2kfdu5NMXpzTEB+tOpUY/aogk=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=uzIPhkdEl1EL42nGrY+GOVyUr7aTldfjmi3rsvfhjJ8ILtn008Y8b+slVMrs1d76
	 G6gLYT6giaFdZ+cuIF03c7fVEINam1jMT35uAgkE1CvKL79hTC4XugSfdUalEWI5M
	 t6Q6/2hMGW8EMTnJHbnUePLWmTi+zzLw3scM3aIZWDnLEPx5t1vRjnXKS1UlUzB0e
	 2L4sApsBgIgyKGDIWQxVqLtrK8MQ+QY8xroF3tQDqFVJ2MYBZI28oC7f9qsa/nEIQ
	 c8PnDni3kRbjvsQlFGILN0WPNz31ec95v4+kEaZpjWfRTlmeLG6M+pJyxUvzkNYVV
	 bbFkwSjTjM+NoEJSJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1ZN-1rnuQR2L9T-00dQVo; Thu, 07
 Dec 2023 16:10:24 +0100
Message-ID: <d49e09f4-b24d-4d27-a03d-e55f1818d200@web.de>
Date: Thu, 7 Dec 2023 16:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: cfr@inria.fr, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rpuePdUaxvsBzh+/d7352hliHZi/n6NAFKV44FfgWsh1N0v9cMx
 nYK+abH90DdtgEWxD3L3dQ/OZBroGjBHFyO2muMmeGqZ10bC4sS7naHvg7/zRIe4Ll9JMMx
 WyjfKdLP8nGWx4Hm4BMIj09EKwPo3+KPjW11BppXACVZBrOz7RNN5yXoAQaGvrTfF7Mr7rv
 rjzLxrzlyUNWk1lztz+fQ==
UI-OutboundReport: notjunk:1;M01:P0:QCI2IKKE9LU=;7O7vOiU2jegzJPWhV0hOHJNkuHo
 eThnio6MKgxmYbfC9eFk+Vcp16+f/0wjs3uWqcY5ClBj5bjcTEd9v9Ujk8Sy9TjHiHwUHz3tN
 KPR0rAqK3pWuL0wJDsJNj0gZd+IryWo5QH3LcWBGW6Ktc0sy+fIYzeTMSmvzj3DNXlB6IVEhl
 c76DqZwnptMZkALX+zLNTSQT0i5zpEF9pYJ7XxeeI7m/52FYLC6VvrUZOUmdH1iWB5wW/xMJF
 yS7lug1+3/59/OhjrRtXKS0JV0Y0NqqWD6yQP0+Lt6q0zdWkcvv3sK4/W2ZwLpIsz1nl8BYAK
 BF94k7nF6HLF8XjFTpuTpOri0leBhvTzmHQu6OBIuiKZoCF9WHue2sKRsEP3eqe+GcDL6V1vw
 ewmN8IFCuHT9p/eubpJVFne9xNlwOHP+NZHXHt9sK1PYQ/fd+ZrPk9nCijuTh4L8FXYHwk1o3
 VBfRs+oL4sSNDhuvi54mSm8714Auhnv4txSEo9sOGs9UUhFEi01SIPhsLndF+UvfQtmvfRr3Y
 N3yRFB3x95qJu27Jl0tddi79iOoAauR2B83eickq7bOSLypuVsY2vaJ1XAupKXY7Xu8I51MqA
 jlHikKk3jkcyh4TlRI4OQlpyFUCu4dzrcnuiN2sh77ZRfFfoXFxAQF1lkFa+4TTpojCrYC0N8
 2CmudCkv/RCDzeD8TU2n+7dt23YlvcD96f4SCMGgN1Es5bbzkd+1FOfhJbEJsf3BNWUYeq519
 L0W2OwoUc3lPli7sPsb27+Vsju+tHSwfxSSbghLMH38beJuI3vwrhoxzCsC1S/IkFLR1LUoLj
 aCwav9rhgxInCRNkuBrL/hwT52wpIIuUl7HHN29oxM/wo85wWIfjMlO0I+3d59uazijHxlPPo
 3753JW8Ej3sV+snsXdrKLN7Cs6dQbADdGzIZzFkd1WdFYoPJ7peEbGVcQrRJA/Uc0PPZVrNki
 71Nvcw==
Subject: [cocci] Software evolution according to Coccinelle for Rust?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1345
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/d49e09f4-b24d-4d27-a03d-e55f1818d200%40web.de>

Hello,

The application of semantic patch languages can be extended for some programming languages.
Will the knowledge transfer benefit any more also according to involved software components?

Regards,
Markus
