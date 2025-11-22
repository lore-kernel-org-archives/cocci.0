Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C60ACFD317
	for <cocci@archiver.kernel.org>; Mon, 24 Nov 2025 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RVS0zpRfIl4H9hjN9Gsnz9HU6fNZFKYbuKVMZDTQ2Gw=;
  b=DBMFLQfUXGFnXIr2LlurGvezekJTmOPj4qEn7MQsB1xawrnKe2+h6PzV
   JlpKHhBhYq54sNZIpOxaaDOiOg3yHpjmjZ/vmK/cbwhFWWYbaDoWImULU
   WGL/dKEB69tnCMMC5G5PE0M9hhqaxRh3CYeu2JfYjwgqH1++XbuYTxosm
   U=;
X-CSE-ConnectionGUID: m1u9ediYSkSsb5Axgi5TZg==
X-CSE-MsgGUID: yVFEKg+qRp+nVBqJn2ctQw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.20,222,1758578400"; 
   d="scan'208";a="250813888"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2025 11:30:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F504E0172; Mon, 24 Nov 2025 11:30:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0EA40E0171
	for <cocci@sympa.inria.fr>; Sat, 22 Nov 2025 02:43:35 +0100 (CET)
X-CSE-ConnectionGUID: xRzNIaR6Q1WlGYubg+na9Q==
X-CSE-MsgGUID: YQibxGvDQl68PQePtaitcA==
IronPort-SDR: 6921152c_Fjnvh9epzB/IbpXFYW7XQBnuT83Rrqv5cHXt4cFXaaD94/y
 Q5pekYskyzWftwPDvJo7WN6HYVBPFtZo+UK3D7g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EiAADXFCFpg/4EaaxaHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?j+BYDMEC0mMcV+GWKA+gX0CDwEDAQ1RBAEBAwSFAAKMXwIeBwEEMAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQBwBLIZPDYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg1+AgEDMgENAQE3AQ8ZOFYGE4MCgiMHSgO0I?=
 =?us-ascii?q?IEBggwBAQbcJYFkCYFKAYVth2NxRIM6eicbgg2BFYE7gi2EWIYvgzSGJ4JTH?=
 =?us-ascii?q?pBLSIEeA1ksAVUTDQoLBwVbgQgDNQwLKhVuMh2BJD4QCHOEXQ8TaA8GgRKDU?=
 =?us-ascii?q?QaJFw+KcgMLGA1IESw3FBsGPm4HlCxRgicHWDaWSoJwAYxwgiGhDoQmgWSfc?=
 =?us-ascii?q?xozgUuWB5MZLphYo2IOhVGBaDqBXDMaCCgIgyJPAxkPjiEJAw0JiHHBciI1P?=
 =?us-ascii?q?AIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23:BfYLBh2qyj8SymsSsmDO1A0yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeEo60xxwWSBNiAo7Ic0qyK6PumATdBqb+681k8M7V0HycfjssXmwFySOWkMmbcaNPMUWkRM
 f8GamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj4VvJrwtxhbGrXdEZepbyX5oKF+dgh3w4tu88IN5/ylftf8s+dRMXbn0cqg9U
 LdVECkoP2cp6cLkshXOURGB7WYGXGUMlRpIDQnF7BXkUZr0ryD3qOlz1jSEMMPvVbw6Viys4
 KhyRBL2hykJKiY1/27LhMN+iqJbuw+hqAdkw4HIeoGVNeFxcb3bcNgHWGdORMdRVyhGAoOhc
 4sCCvcKMOhEo4XhoVYFsACzDhewCuzx1jBIh2f23awk3OQnDQHGxxErE9YXvHjJsNn5KKIeX
 Oaox6fK0DrDdetb1zfj5oXWbx4vr/KCU7VyfsrfxkYhGBjIgkmTpIH/Iz+YzPgBv3Sd4uF9V
 eyvkWknqwRprzaq2MgjlJLJjZ8Lx1DD8iV5w5s+KNq7SEFlf9GkC4BdtyKEOItsRMMtXWVot
 Dw9yr0ctp62ZS4Hw4koyBDDcfKIaZSI4g79W+aLJzd1nHJoda68ihux80WtxPDxW8203ltWo
 CdIjMfAuHAN2RHP5MaKRf9w80mu1zuMywze7uNJLV02mKTVN5Mt37E+m4QVvE/eHSH2gF37g
 LKUe0k64OSk9vjrb7X8qpKTLYN4lAHzP6s2lsCiHeg0LhICUmqb9Oim0LDv41f1TbVJg/Awj
 6LXqorVJd4Bqa68GwJV0pgs6xK4Dzq+zNQYmmMHIEheeBKAkojpIU3BL+7iAfe8nVusijFry
 O7CPrH7BZXNNHfDnK/gfbZ79UFc1BI+wc1d6p5KEL0NPe7/V0/ruNHXFBM1LQy5zun/BNV4z
 IweWGaPAqGDMKPVtF+F/uEvLPeSa48Oozv9KOYq5+TojXAnnV8RZ66p3YEYaHygBPRpP12ZY
 WbwgtcGCWoKuhAxTeLwh12GVT5efHezX6M55j4gEoKpF53PRoGrgLyb3Se0BIdaZm5cClyUC
 3fna52EW+sQaCKVOsJujjsEWqS9RI8gzhyurw/7y79/LuXO4CEYtJTj1MJ05+LJjx0y+yZ0A
 9yb026WV250hH8HRycq3KBjpkxw0kmP3bB3g/NGEtxd5OlHXx8kOJPA1+B6Ec79WhzCcNmTU
 FumXtKmASsrQtIqxN8Oflx9FMm8gRzZ3CqlHaUVl7qVC5ww6K7c2GLxJ8llx3nb16khjlwmT
 9NXO2OpiKFx6RTdCpLPnUmBiqmqcL4T3DTR+2qb1WSApVlWXgFoXaXeRXAfaFPbo87l603fU
 rGiEa8nMhNPycGaKqtFdNnpjVJeSfn7IdrQe22/yC+MAkO2wrqXcIvvemFV9izXC0FMxx4Z9
 HyFPCAlGzys5WnMWm9AD1XqNmDh/PI2g3S8TQdgzAyHdGVi2qCz9xpTguaTHaBAlokYsTss/
 m0nVG222MjbXp/Z/1IJlMR0ZNo85AwCzmfFr0lmOYTmKal+h1kYegAxvkX01hwxBJ8T2dMyo
 iYMywx/YbmdzEsHbymRiJP9N6b/KWTo+h2rLanM1QKWy86Yr58G8+9wsFD/pEesH0sm/W9g1
 oxW3naHzpbHFgwfVdT2SElkvwNiqeT8ZS8wr5jRyWUqMaSwtWra3Mk1AeI+1hu6V8tYKuWfE
 xLoGMBcBMW0LuEu3V+zYXroJch086g5d4OjfvqCg+uwOfp42SmhlSJB6Zx81USF82x9TPTJ1
 tAL2aPQ2AzPTDr6gFq716K/0YlZeTEfGHa+win4FcZQYKN1Z4MCFWapJYW+2Nx/g5fnX3MQ+
 kSkAhsK38qgeBzaaFKYv0UY1kkaulSklDG+wjgylCsm7+Ke0CHI3+X+ZU8fIGcYDGJmjFrqP
 c21l4VDAxLuNlB00kfjvxumlM057OxlImLeQFlFZX3zJmBmCe6rs6aaJtVI8NUuuDlWV+K1Z
 RabTKT8ql0UyXCGfSMWyTYlejWtopi8kQZ9jTfXL3t+t1LadNt2yBOZ48bTD60Zzn8dSS90h
 COCTFuxMsKB/tiOkZrH9OekWCjyM/8bOTmuxoSGuiyh4GRsChDqhPG/lOrsFg0i2DP63d1nP
 cnRhC71eZKjl6GzMOY8O1JtGEe58M1iXId3joo3gpgUn3kcnJScu3Qdwy//NtBS2KS2a3RoJ
 3ZDwNPY+yDm1VdlI3bPwJj2HnmQ2cpuYdCmb3heg31nqZkSVeHIquYZwWN8uRKgoBjUYORhk
 ztV0vYo5HMAwoRr8EIswiibHrEODBxdNC3omQ6P6oP2p6FWaWCzNLmogRMhx5b4VOzE/kcGB
 SqqH/VqVTV95ch+Ll/WhXj664W/PcLVccpWrRqM1RHJk+lSLps10PsMnytuf2zn7hhHg6Y2i
 wJj2Zaisc2JMWJoqei6DxNDHj74fcUe/nfql6kUzY6GmpuiGJlsAGBBX5blVtqrHSgUuPChM
 ByBWm5ZyD/TCf/UGgmR711jpnTEHsWwNn2ZE3IeyM1rWBiXIEEMyBBRRjgxmYQ1Uxy73MG0O
 lks/SgfvxSrz3kEgvItLRT0VX3T4RuleithAobKNwJYt0lD/xuHbJbYtL81RnoJuMT99ESMM
 jDJPl8ZSzhWCgrUWxa5Z+bLh5GI8vDEVLPicr2SOfPQ+aoBCr+J3c79i9c7uWrUcJrUeCQ/R
 /wjhhgaAS8/RJmfwmRUDX1O8kCFJ8+D+EXlpXcx95jitqitAl+zrYqXV+kLbo8poUvqx/3eb
 ajL3W54MWoKj8xWgyWTlP5GhgZU0HELFXHlEKxc53eSFuSJwvIRUUJdMnMvfN1B66Z2tuVUE
 ejcjN69lrtxj/puTkxASUSkgcaxI8oDP2C6MlrDQkeNLrWPYzPRkYnxZuunRLtcgf8x1VX4s
 CuHE0LlIjWIliX4HxGpP+ZWiSiHPRtY8IijexdpAGLnQZrocBq+eNNwiDQ3x/UziBaofSYEN
 iNgdkpWsrCKxT9fmLNkHHFb5XcjLuSenSudqe7CJddesPdmBDh1i/MP4Hk+zOgwjmkMT/h0l
 S3O69929gj5yK/WkmchDFwU92oY4eDD9V9vMqjY6JRaDHPN/RZWqH6VFwxPvNx9TNvmp6FXz
 NHL0qP1MjZLtdzOrq5+T4DZLtyKNH05PF/nAjnRWUEGQDOwHWLSnUpQlLeV7HLf/f1Y4tD83
 YEDTLNWTgl/DvQBFkFsB8APOr9rWSliirmGlsUFo3mzth/cQINdpJ+NBZfwSb3/bT2ei7dDf
 R4Bx7j1eJ8SOoPM0EtnclBmnY7OFiI4vPhRpTcndQgpuk5AtntzVGs+3wTicAz/uBf78Na3k
 wQwhw84Zv4ipm+EC7gfJVfQoiY01k4rloe86Q0=
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:m1les6GhkgGFO6+PpLqEN8eALOsnbusQ8zAXPo5KJyC9Ffbo7/
 xG+c536faaslYssR0b9exofZPwJE80lqQFhrX5Q43SPzUO0VHAROoJ0WKh+UyFJ8SUzI9gPM
 lbHJRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DshPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AllC1GmrGUDnT44AB6zsk4SvmUdAfYFv8xU2OGha?=
 =?us-ascii?q?HDUlYVbeaClmZqZoxxg=3D=3D?=
X-Talos-MUID: 9a23:hEAivgQp3CCZXHLzRXTdvTBoJOh2z52qVhA1qJg+p8CFKSdZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,217,1758578400"; 
   d="scan'208";a="131590871"
X-MGA-submission: =?us-ascii?q?MDH1tMI+vZBAUi5/BHdUhz+67qb6Un4zt/cycw?=
 =?us-ascii?q?Ki1rDXYCGNVe9GuRcgD2gAWFFB5GMnp5Y88XDO95cslpr3Fd4K5+NjeR?=
 =?us-ascii?q?xTpIWNndFju6w4M206sFnY4AQfPBV5AZ+Bl4h920TKVs7UjEVHVH4rvB?=
 =?us-ascii?q?teRE7y2rl0mqgqF7EB4JF4GA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 02:43:08 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AC31060172;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45596C116C6;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763775785;
	bh=JxuvIO3718cS+Dvv5mnYaQfpRZs89bnBJgRU4fqHVhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMvlgijzbmFNkfbnQVSo6QNnc2jbeN9HLvXWjQOD93VkbfHKnVlUY7eOKEBcuHc67
	 6PayG7QOl6uN5Vz7SX/SjbnnvJVTQSEFclQ3E+RQMEN37u2gsLaJDrutd2UEd1hPKn
	 eHktdbFsp5skk56TH79GEktt7iA/iT2S0Qrad486wiP+ow/jAeOAJNCJmRYglKwsM+
	 9a0RORXbOB7nHKxtWvj/g0k5k++pY7QHTI9D4WK65u6qIM8mqN4C23qYwhkfzWSWS1
	 eNUUfNb2zOrPMBidmcWKFrNloeo0lQC+OG0v99oD132px4tyS1RAxPzJgAcV2eS+tF
	 wFnZ3vu36liyw==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Date: Fri, 21 Nov 2025 17:43:00 -0800
Message-Id: <20251122014304.3417954-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122014258.do.018-kees@kernel.org>
References: <20251122014258.do.018-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5220; i=kees@kernel.org; h=from:subject; bh=JxuvIO3718cS+Dvv5mnYaQfpRZs89bnBJgRU4fqHVhg=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmKoiovd0kEL2nM9vrWcEr0BrNDueiFSz1VT7Ynz/mxU HCv85o3HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABORKWdkeMS4oWH2j/3ayy4U ntTmmnLqyr3eozWS3Heu/Np3OmE6822GP3wLym6t6qhK1xRnlXp2RrSzPrjMxZRN3oOxU9LE8eY tFgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v5 4/4] coccinelle: Add kmalloc_objs conversion
 script
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3195
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/20251122014304.3417954-4-kees%40kernel.org>

Finds and converts sized kmalloc-family of allocations into the
typed kmalloc_obj-family of allocations.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
---
 scripts/coccinelle/api/kmalloc_objs.cocci | 168 ++++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci

diff --git a/scripts/coccinelle/api/kmalloc_objs.cocci b/scripts/coccinelle/api/kmalloc_objs.cocci
new file mode 100644
index 000000000000..39f82f014b17
--- /dev/null
+++ b/scripts/coccinelle/api/kmalloc_objs.cocci
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use kmalloc_obj family of macros for allocations
+///
+// Confidence: High
+// Comments:
+// Options: --include-headers-for-types --all-includes --include-headers --keep-comments
+
+virtual patch
+
+@initialize:python@
+@@
+import sys
+
+def alloc_array(name):
+	func = "FAILED_RENAME"
+	if name == "kmalloc_array":
+		func = "kmalloc_objs"
+	elif name == "kvmalloc_array":
+		func = "kvmalloc_objs"
+	elif name == "kcalloc":
+		func = "kzalloc_objs"
+	elif name == "kvcalloc":
+		func = "kvzalloc_objs"
+	else:
+		print(f"Unknown transform for {name}", file=sys.stderr)
+	return func
+
+@assign_sizeof depends on patch && !(file in "tools") && !(file in "samples")@
+type TYPE;
+TYPE *P;
+TYPE INST;
+expression VAR;
+expression GFP;
+expression SIZE;
+identifier ALLOC =~ "^kv?[mz]alloc$";
+fresh identifier ALLOC_OBJ_SZ = ALLOC ## "_obj_sz";
+@@
+
+(
+-	SIZE = sizeof(*VAR);
+	... when != SIZE
+	VAR =
+-	ALLOC(SIZE, GFP);
++	ALLOC_OBJ_SZ(*VAR, GFP, &SIZE);
+|
+-	SIZE = (sizeof(TYPE));
+	... when != SIZE
+	P =
+-	ALLOC(SIZE, GFP);
++	ALLOC_OBJ_SZ(*P, GFP, &SIZE);
+|
+-	SIZE = (sizeof(INST));
+	... when != SIZE
+	P =
+-	ALLOC(SIZE, GFP);
++	ALLOC_OBJ_SZ(*P, GFP, &SIZE);
+)
+
+@assign_struct_size depends on patch && !(file in "tools") && !(file in "samples")@
+type TYPE;
+TYPE *P;
+expression VAR;
+expression GFP;
+expression SIZE;
+expression FLEX;
+expression COUNT;
+identifier ALLOC =~ "^kv?[mz]alloc$";
+fresh identifier ALLOC_FLEX_SZ = ALLOC ## "_flex_sz";
+@@
+
+(
+-	SIZE = struct_size(VAR, FLEX, COUNT);
+	... when != SIZE
+	VAR =
+-	ALLOC(SIZE, GFP);
++	ALLOC_FLEX_SZ(*VAR, FLEX, COUNT, GFP, &SIZE);
+|
+-	SIZE = struct_size_t(TYPE, FLEX, COUNT);
+	... when != SIZE
+	P =
+-	ALLOC(SIZE, GFP);
++	ALLOC_FLEX_SZ(*P, FLEX, COUNT, GFP, &SIZE);
+)
+
+// This excludes anything that is assigning to or from integral types or
+// string literals. Everything else gets the sizeof() extracted for the
+// kmalloc_obj() type/var argument. sizeof(void *) is also excluded because
+// it will need case-by-case double-checking to make sure the right type is
+// being assigned.
+@direct depends on patch && !(file in "tools") && !(file in "samples")@
+typedef u8, u16, u32, u64;
+typedef __u8, __u16, __u32, __u64;
+typedef uint8_t, uint16_t, uint32_t, uint64_t;
+typedef __le16, __le32, __le64;
+typedef __be16, __be32, __be64;
+type INTEGRAL = {u8,__u8,uint8_t,char,unsigned char,
+		 u16,__u16,uint16_t,unsigned short,
+		 u32,__u32,uint32_t,unsigned int,
+		 u64,__u64,uint64_t,unsigned long,
+		 __le16,__le32,__le64,__be16,__be32,__be64};
+char [] STRING;
+INTEGRAL *BYTES;
+type TYPE;
+expression VAR;
+expression GFP;
+expression COUNT;
+expression FLEX;
+expression E;
+identifier ALLOC =~ "^kv?[mz]alloc$";
+fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
+fresh identifier ALLOC_FLEX = ALLOC ## "_flex";
+identifier ALLOC_ARRAY = {kmalloc_array,kvmalloc_array,kcalloc,kvcalloc};
+fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARRAY) };
+@@
+
+(
+-	VAR = ALLOC((sizeof(*VAR)), GFP)
++	VAR = ALLOC_OBJ(*VAR, GFP)
+|
+	ALLOC((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+|
+	BYTES = ALLOC((sizeof(E)), GFP)
+|
+	BYTES = ALLOC((sizeof(TYPE)), GFP)
+|
+	ALLOC((sizeof(void *)), GFP)
+|
+-	ALLOC((sizeof(E)), GFP)
++	ALLOC_OBJ(E, GFP)
+|
+-	ALLOC((sizeof(TYPE)), GFP)
++	ALLOC_OBJ(TYPE, GFP)
+|
+	ALLOC_ARRAY(COUNT, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+|
+	BYTES = ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
+|
+	BYTES = ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
+|
+	ALLOC_ARRAY((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), COUNT, GFP)
+|
+	BYTES = ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
+|
+	BYTES = ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
+|
+	ALLOC_ARRAY(COUNT, (sizeof(void *)), GFP)
+|
+	ALLOC_ARRAY((sizeof(void *)), COUNT, GFP)
+|
+-	ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
++	ALLOC_OBJS(E, COUNT, GFP)
+|
+-	ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
++	ALLOC_OBJS(TYPE, COUNT, GFP)
+|
+-	ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
++	ALLOC_OBJS(E, COUNT, GFP)
+|
+-	ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
++	ALLOC_OBJS(TYPE, COUNT, GFP)
+|
+-	ALLOC(struct_size(VAR, FLEX, COUNT), GFP)
++	ALLOC_FLEX(*VAR, FLEX, COUNT, GFP)
+|
+-	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
++	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
+)
+
-- 
2.34.1

