Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560B1C02192
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2025 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xSy52ZvtkkctLJ0X7bJ1xyeh2hpay1+QXC3vAk3CiUE=;
  b=P/C/YHlmducQDwG8Yz0B2mrgrTy6ObiEjjlD08WKMsTRHChJ/uFpaFuP
   ZkZJRQn7Ld2HIC5I/fVT4UgYwSnBCu2VrE6LmXp4UxGXPXKh45z4vg8CP
   B7S2Q9hAGyxBUC9ukN1Hx8jokG4MHkvY+1nGv1ALTY8Y1CCOEOIad2Hp2
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207091166"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2025 08:44:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A9EE6E0D1E; Fri,  7 Feb 2025 08:44:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 16710E0260
	for <cocci@sympa.inria.fr>; Fri,  7 Feb 2025 08:44:07 +0100 (CET)
IronPort-SDR: 67a5b9c6_S7uqL3EOZIwTpbaBT2CiWQN4gkJRIrsSq1nDWi3pVkk7OpV
 VMPd9+PmuE4MsabBc86tM4SUisGhSufZ7O4z9Ww==
X-IPAS-Result: =?us-ascii?q?A0FNAgBguKVngwsR49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDYnUzBAtIhFaPT4F0MIQ7hzuQSIFWgX4PAQMBDUEBAgQBAQMEOIFUgnQCi?=
 =?us-ascii?q?wICHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBO?=
 =?us-ascii?q?gcOCjGFQQgyDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBB?=
 =?us-ascii?q?AsLGgImAgJWBgEUAQGCfoIwAQMOIwexIYEygQGCDAEBBtpcHywiV4FlCYEaL?=
 =?us-ascii?q?gGFa4JjAYYmhDwnD4FVRIEVJ4MDPoRDg1uCaYIzgnGBV2eXH4NBiF1SexwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSlIAyo2MSOBIwU1QTqCDWlJOgINAjWCHiRYgitqBAWBLYI5h?=
 =?us-ascii?q?EOETYVYghKBYAMDFhABgjFweByDWi8dQAIBC209NwkLGwY9nxKGcjBPKZMes?=
 =?us-ascii?q?nE0B4I4gWaBYwyfXAYTL5dDDgaSeyyYUCKjb4UdgW4BMoFcMxokgzZPAxkPj?=
 =?us-ascii?q?C6BcxmEFMZWQjU8AgcBCgEBAwmFRgEBil+BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fqI2/aA5RR6HPbflHel455DYdb4zR+YMi2TDGXoBLSC9Afbo8v
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:dz2h02PJgYOgZO5DaBJH2G0WE+8eKl7083P2ZGjkSlpTR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ASADy4g8lTEuiByNR0+pT8UOQf/xj2YSzA2oQq64?=
 =?us-ascii?q?Dlc7aEwxBKR3CtQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207091157"
X-MGA-submission: =?us-ascii?q?MDFG7kkynfxPhY9WFAwDBVkYK9ZcEgLKj8sJS5?=
 =?us-ascii?q?9R/6DSPBF2dNZGgGggXlA+1zciYz79tfNVqhwTNVbl70xXUnSt25j/yS?=
 =?us-ascii?q?4t7AkOUBP72bvIIxqTRVDlbcMI2y4UIfOMzIG+UWN4MmDlKpQrgRF9fv?=
 =?us-ascii?q?p1ILbDb9mnJ8yABBfkRDTJYw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:44:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738914240; x=1739519040; i=markus.elfring@web.de;
	bh=xSy52ZvtkkctLJ0X7bJ1xyeh2hpay1+QXC3vAk3CiUE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cfVHG4u+PX7aiXiYbVNIBROr+57m8FywkyOqHMXrSGZW/a2KTSwVbnNs/nTM7NSL
	 sL6GDD/rCwF7XjCykeFbQ4GfoK20b+/Kk4YKXwPdYqA4f57IWQfyih886yySfMSpa
	 ApjVlCNzyepxBT+/3j1MQrjBAxbcB4Pmht7CAnUYSy100kbXGTd3okYNqVg0MAfop
	 Uh3pu2dVwg5Nt7N0UtPkvNEjvwO3VnHZxVj77M9x3aZCvTCv4/cPzRWFrGdn/dWDB
	 W20LFsKUNNFL9ED40tCp3Bm16ZhKmgbYGaS/mIm34vt6ENPhi1fsTF7yhKyHFGpAs
	 a3wn+vtCT4YoFjb4Ig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.29]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHWx-1ts9OX2pJV-00O54c; Fri, 07
 Feb 2025 08:44:00 +0100
Message-ID: <9bfe9c42-ef0c-44ae-a71b-26207e9083ad@web.de>
Date: Fri, 7 Feb 2025 08:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
Content-Language: en-GB
Cc: Johannes Berg <johannes@sipsolutions.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CeM5A2HqHyOrdAApmH3jCWcMAdH3kXUEebrhYkOSwjsgrgcKpXz
 E0Zw1Ma3UjI3tUylSGUNGCliQbLc2VBOMfPsE9YVq7HecIA4GfqKtvCjQf5X3Fm62RykeMe
 nz1vPb7u1RftyKLJS/spe9ld/sdokKdMzXPMx7FXu1RG5bplHZFG4WLXXiZ3wddTQ5FoLsk
 f8uO8CJwvADj93DjIJevA==
UI-OutboundReport: notjunk:1;M01:P0:rKlFnIY9ioo=;NQCxAd6GcZR+NUbq6xvQ0ECA0K3
 MJI3itYcoresF46qrVMnNZ/rca6nuoOZeJ2MdMwz7M5i3iGjyShvmbo/q70XTGkvsgAPpNwtf
 1s2ruOIkH9l2iMtg8iPe+hilhMokaFBz+m1FMMbFD/oWqf/hAV9JAhcv7AnKbZLCpEkmsKsZT
 WnIDHMYsnw3uIC82UwcAum6dLzlr/zDdvCNjvhB7rdUeQthvndkIkG5RmbifR8GjOnx8KYQVj
 XR+wVVvxEGIMTXofCaMzz7zelgfvTPltzyCqqUxfR7+zH0EkJ6dmUi2cRkCuiYyAj8rvGCjYi
 mj3q1EIbQRxAOV8lckU8cAbwyueVq9w0lPo7FUXym91+G75u5Che1vstrvXZUkKqFgLGIk24U
 bfft/tc0bJfpb9ICvKRmy/yvN3n0XeHLbJXYt5EFQdOb9zVMPg0cqRvaNaYyAEElB+zRDVlAC
 50VcNWSzxkBv6FCeZo9x2brcUCfsGdCMq0OxMragz+MgX0knxg9pffbW2sDWF4KF+GrFM4RTh
 DX+Acf5ewt6CgOXnsYkX93ZLxkDmNFJ1X7jlpM2nrkdcbVV1NCSbCwOc9fbzQ9DWYZ6ptEZpk
 WsKUpuUJGYVgPP/oGIowzuKv19K0DyN59aQ2UUALku9tXYYU/Lud/6R0f8rI0AAPDJTpm+JZe
 LQg/IWnvI67zqq+OqQcrQFZETcB/hVjKqfDKdQ3s0XSWv6GmPRwia8nleDhdKPY30JT8GVPfF
 64KV2Ou+JrbHZnplxjXXZdzQqryGjsJ9MJ12YzD+n9eR5hiNNbZClRvV6v77tVlcyoOkjIJm1
 cEouT5tE/bJ922agVfSEAvs/tdfXqzKik5kDkUyPemLIP6vC8it8SlF294QJ/TTltX3D8vhF7
 /MyjJR0lAjpP+HwsD98PzzHKuW2ru/F4MLFBR9eQaLimBwSGDLx/JQu0rrpdJLMtszRmCJDAL
 wgzeGtVOyse6oXHPXMJiNI3hK8cxx4X8jR5TcFExgStSuUKW71ugzonGriLe07oknlMvL5RTd
 hSygof84x1hSr5IVYAq1tBrbQmhK6KmDiz+F58ozU5Uuuo7tJwJYli0fSaDZD6Yz1+3WzFfv8
 LZrnGBup6+P2fK/h89egINd09HHhX47dXpHWkZhaBAJ/UZFFA4FABDQNLPS0cBsGVMRCy5lOJ
 KyN9+6eMw6tWCe9/gsP8O5AR8Vl1JD7LG9rUd9dZo3UK7+FMUA40qipw/BGlVEM2VJi4YIUYP
 rpv2xgcDSAQmh8pE9HEmREuuprzIKopIIPnAwKrb7/Ydq4Td03pxFZ6PbA+nREDooBJpS02Ks
 5KO/FVc/Z49LaF+qijiXrGpnwMav6bI+ZI5CLdVmZyW+o2mn3IDQa6dMl6tu2sa930zp5UQo7
 IqzRmV5GHgGMgDCu8iy4ZoQw6EL3Lqd/ftzgTQPn/HZoisnMYWMii004OIYki8gEB6azfj/4c
 wg6/5rA==
Subject: Re: [cocci] Checking software run time characteristics
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2366
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/9bfe9c42-ef0c-44ae-a71b-26207e9083ad%40web.de>

> You can try --profile to find out what it is spending the most time on.
Would you like to clarify measurement data (like the following) any furthe=
r?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time spatch --pr=
ofile delete_statement1-Johannes_Berg.cocci extract-ieee80211_get_mbssid_b=
eacon_len-20250206.h
=E2=80=A6
diff =3D
warning: rule starting on line 4, node 52: [fortrue][1,2,17,18,19] in ieee=
80211_get_mbssid_beacon_len may be inconsistently modified
warning: rule starting on line 4, node 55: statement[1,2,17,18,19,20] in i=
eee80211_get_mbssid_beacon_len may be inconsistently modified
warning: rule starting on line 4, node 30: [fortrue][1,2,6,7,9,10,12] in i=
eee80211_get_mbssid_beacon_len may be inconsistently modified
warning: rule starting on line 4, node 33: statement[1,2,6,7,9,10,12,13] i=
n ieee80211_get_mbssid_beacon_len may be inconsistently modified
warning: rule starting on line 4, node 51: for[1,2,17,18,19]* in ieee80211=
_get_mbssid_beacon_len may be inconsistently modified
warning: rule starting on line 4, node 29: for[1,2,6,7,9,10,12]* in ieee80=
211_get_mbssid_beacon_len may be inconsistently modified
=E2=80=A6
Note: processing took  1083.7s: extract-ieee80211_get_mbssid_beacon_len-20=
250206.h
=2D--------------------
profiling result
=2D--------------------
Main total                               : 1083.707616 sec          1 coun=
t
Main.outfiles computation                : 1083.691804 sec          1 coun=
t
full_engine                              : 1083.691654 sec          1 coun=
t
bigloop                                  : 1083.679190 sec          1 coun=
t
Rule rule starting on line 4             : 1083.679188 sec          1 coun=
t
process_a_ctl_a_env_a_toplevel           : 1083.676273 sec          1 coun=
t
mysat                                    : 1083.676131 sec          1 coun=
t
ctl                                      : 1083.674814 sec         35 coun=
t
pre_engine                               : 0.015786 sec          1 count
parse cocci                              : 0.015455 sec          1 count
show_xxx                                 : 0.010977 sec         11 count
HACK                                     : 0.010574 sec          5 count
Common.full_charpos_to_pos               : 0.002770 sec          2 count
C unparsing                              : 0.001845 sec          2 count
Parsing: 1st pass                        : 0.000956 sec          8 count
YACC                                     : 0.000933 sec          8 count
C parsing.fix_define                     : 0.000724 sec          5 count
C parsing.lex_ident                      : 0.000611 sec       1418 count
LEXING                                   : 0.000462 sec          4 count
flow                                     : 0.000359 sec          4 count
C parsing.fix_cpp                        : 0.000349 sec          4 count
MACRO mgmt prep 1                        : 0.000301 sec          4 count
asttoctl2                                : 0.000281 sec          1 count
TAC.annotate_program                     : 0.000257 sec          2 count
C parsing.lookahead                      : 0.000182 sec        546 count
C consistencycheck                       : 0.000140 sec          4 count
Transformation3.transform                : 0.000127 sec          1 count
Type_c.type_of_s                         : 0.000085 sec         23 count
Common.info_from_charpos                 : 0.000070 sec          2 count
worth_trying                             : 0.000058 sec          1 count
fix_flow                                 : 0.000051 sec          2 count
C parsing.mk_info_item                   : 0.000050 sec          8 count
Common.=3D~                                : 0.000043 sec          6 count
MACRO mgmt prep 2                        : 0.000017 sec          4 count
Main.result analysis                     : 0.000010 sec          1 count
TAC.typedef_fix                          : 0.000009 sec         58 count
TAC.add_binding                          : 0.000008 sec         10 count
C parsing                                : 0.000006 sec          4 count
check_duplicate                          : 0.000006 sec          1 count
post_engine                              : 0.000006 sec          1 count
Main.infiles computation                 : 0.000001 sec          1 count
TOTAL                                    : 0.000000 sec          4 count


real    18m3,734s
user    18m1,192s
sys     0m1,021s


Regards,
Markus
