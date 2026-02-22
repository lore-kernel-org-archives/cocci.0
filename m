Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80024E9B24D
	for <cocci@archiver.kernel.org>; Tue, 24 Feb 2026 11:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FcEUKGf/5JzEVQ7P0cqo0K6+/Vz4oXHWWUqIJr+YsO4=;
  b=OkmryGbliVxatdypBuS7trUIgfUDiwQ/ejsikQqyKcNdzQfXCuTBj7rS
   zFx0C0WHd/96Nn6Sf01NEve4j7pQ4g4JiIa++p5zTcrgAYR0O95yo3wT3
   ffRQeyN/L5Soc9v01kf7ttFeQCoRP8gp5/ER+Ct4VnXSzReB3i6q06I4S
   Q=;
X-CSE-ConnectionGUID: rytOfVPdT3qEbOAMJHwlzg==
X-CSE-MsgGUID: uZ66gpQNQI+39lp+TWPhhQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,308,1763420400"; 
   d="scan'208";a="264908127"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Feb 2026 12:04:50 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 75CF083682; Tue, 24 Feb 2026 12:04:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9A62480622
	for <cocci@sympa.inria.fr>; Sun, 22 Feb 2026 08:12:42 +0100 (CET)
X-CSE-ConnectionGUID: u1Q6EXKeSb+YtVpbMwC7uw==
X-CSE-MsgGUID: j7X/xUqBTri5ebgaOfnwdA==
IronPort-SDR: 699aac6a_mZAi50EnnH619LQMSLejgfiK0F7KcKLzrBEwhuDGQvre+KI
 06zyBHo6BT5svILa6Da7yTap9KAWPegjFFj9cRg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HwAQCqq5pphf4EaaxUBh4BAQsSDECBRQuCQYFmMwQLG?=
 =?us-ascii?q?TCNU4ZYgiSBE5E8jUgCDwEDAQ1RBAEBAwSFAAKNIAIeBwEEMwYOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGTw2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINfgEBAQM6BgEBNwEPCw4KLlYGE4MCgiMHSgOofoE0g?=
 =?us-ascii?q?QGCDAEBBtwqgWcJFYE4hW+CZQGFdIQAeicbgg2BFYJyOD6BUoJhhCWCL4Img?=
 =?us-ascii?q?Q6CAIgsiTNSeBwDWSwBSwoTFwsHBTMrRUMDgQYjSwUtChNSEj8hHQ8IFB85A?=
 =?us-ascii?q?h0bBwUSIREZB2VzAgIEghN7ggEPhmp5AyMLYRoOIgI+XFIFPgtgBVEDC209N?=
 =?us-ascii?q?xQbBI9oP4I0AYENgXGUFYM0AY8RgTWfWYQmgWSgQROBOJYHkxkumFijY4Veg?=
 =?us-ascii?q?X4kgVwzGggoCIMiTwMZD44hGYh6tFkiNTwCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23:3NgcqRRYbWQQArY/xTWMsJBix9psomyVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSAcODs7ke0LGI6ejJYi8p39WoiDg6aptCVhsI2409vjcLJ4qoL3O+B9PRKxIAI
 cJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+N
 hq7oAveu8UMnYduNqk9xgXHr3ZGeula235jKE6OkRr7+sq/85lv/jhKtfk87cBAS6L6f6o5T
 bxcEjsrNn0+6dPouxfeUwaB/2MQXGoOnBVHGgTI8h70UIrpviT1quRy1i+aPdbrTb8vQjSt8
 71rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSGFfQsheSTBOAoKkb
 4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOm3T437A10/45HA/I3AIuAcwDvmnXotX7O6gdT
 f26w6vTwDXfc/9bwyvx5JTUfhw/p/yHQLJ+cdDWyUkqDw7Li0ufppL+PziIyOkNtG+b7+l9X
 u+oiG4otR9+oiO0y8cvlIbJnIQVxU7A9Sljx4Y1P9K4RVd9bNW5H5ReqzuUOJFqQsM+XW5oo
 iA6x6UHtJO6fCUH1JsqyRDCZvKHb4WG7RbuWfuRLzp5mH9rdqyyigiv/EWkxOPwSte43VJLo
 yRKjNTAqm4B2RzN5sWJTPZ240Sv2S6X2gzO6OxIP1o4mbfHJ5Mh2LI9mYAfvVrDEyL5gEn6k
 bOaelk+9uWq6+nreLHrqoGGO4J0iQzzNLkllNalDuQiKAcOWnCW+eSi273n+k30WKlKjvosk
 qXDq5DaItkbprSlDABLyIoj6AiwDy2g0NsGmXkLNlVFeAiIj4TxOlHOJu73Deunjlixkjpn2
 erKMqD9DpjNNHTOn63tcah95kNT0AYzyMpQ55NQCrEPOvLzXUrxucTbDhAnLQO02P3qCNZj2
 YMEX2KAHKuZPLnVsV+S6eIjO/OMa5MNuDbhN/gl4ObjjXsjll4TZ6ap2Z8XZWu5H/RnJkWWe
 mDsjc0bHWcLuAo+Vu3qh0eYXT5dfXa+R7g86S0jCIK6EYfDQZigj6CG3CinApJWZ3tLCkuME
 Hftb4WLQe0AaCOUIs97kzwLT6KtS4E71R22sg/10KJoLvDI9S0AqZLjyN916vXNmR0q+jx7E
 cOd3WKXQWxsgG4FWyc63LphrkxjyVmNy7B1g+BfFdxJ/f9JSQA6NYPGz+NmFd/+QAHBccmTS
 FagXNqmBSs9TtUrw98Be0pyBtaijhHG3yeyG7EbmLKECoIo/K/A2Xb9P9tyy3Pc26k7k1YrW
 tNBO3S+iKBw7wTTHJbJk0uBmqiwaakSwTPD+H+YzWqWskFXSA5wXrvBXXAYfkbYtc336FvNQ
 ezmNbNyHxFAwoaoK6RFZ8fyxQFLTvbsN9nEeEqyln22CBLOwamDOtnEYWIYiQbQBVNMuAcU/
 j7SNgUzHQ+irnjYATgoEkjgNRC/udJioW+2GxdnhzqBaFdsgv/sokZ9bZ20TvoS2uhBoyI9s
 3BuG1372dvKCt2Grg4nfaNGYNp77k0UnXnBuVlbOZqtZ7tnmkZYax5+6kDj2g5fCYhal8Uu6
 nQww1k6MrqWhWtIbCjQxpXsIvvSI2j28gqobvvV11zF+NWb4KEC7LI/sVqw9BqxGB8E9HNqm
 8JQz2Pa5pjOC18KVontV08s6xVgj63deG8m4J7O3nAqMqSutDLGndUzC4PJ0z6GeNFSeOOBH
 Q72SYgBAtS2bfYtkB6vZw4FO+Zb8Og1Odmnfr2IwvzjOuEohz+ggWldheI1mkuR6ypxTPLJ1
 JcZ0rmZ2AWATTL1kFamtIj+h4lFYTgYGmf3xzLjAcZdYah7fIBDDmnLQYX/xdhznLbuVmRe+
 VrlAEkJmYeodReUc13hzFhIz01E6XejmCa+03l1i2Rw8fDZhXSThbikLkdbaQspDCF4gFzhI
 Ja5lYUfVUmsNU0ykQe9oFz9zO5drbh+KG/aRQFJeTL3JidsSPjV1PLKbshR5ZcvqSgSXv67Z
 AXQSbPwuDMZ3jnlEm8Ywyo0PWLiqtDikhp2hXjIZnV+oWHxesxqwxrbotvGSrQCu1hODDk9g
 j7RCF+mOtCv9tjBjJbPvNe1UGe5X4FSey3mpW+ZnBOy/nYiQRi2nvTp38biDRB/yyjwkd9jS
 STPqh/4JIjtzaWzd+x9LAFkA1r16swyHY8b8MN4h5wdwlAZi4+T8H5Bln38edlWwqPxanMRS
 CVDmoGPplG9hQs/aCjUm8rwTT2Fz9FkZsWmb29ewS87481QScL2pPRFkSZzvlukvFfUaPl5k
 C0azKhm43objucV/Qs1m3zCWPZLRRQeYWq2ykjbirL25L9ab2uub7WqgU93nNT7SaqHvhkZQ
 nHyPJErAS536Mx7dlPKynz6rI/+K7yyJZoesAOZlxDYgq1bMpU0w7AJiCd8EWHwp3soz6g8l
 xMkjtmq+ZOKLWlg5vfzARNVLRX2atkV9zWrirxR1JXzvcjnDtBqHTMFW4HtRPSjHWcJtPjpA
 A2JFSU1tnaRHbeMVR/a8kptqGjDVoy6L3zCbmdM1s1sHVPOQS4XyBBRRjgxmYQ1Uxyn1NC0O
 lks/Sgfvxb5skcel7gubUS5CzyO4l70Mn81UMTNdUUMqFgaugGJd5bDsocRV2lZ5sHz9VPXb
 DbAO0ISUDtPARXMBki/bODxv5+aqLTeX7DmaaCeKbSW9b4HCK3OnMrylNU6uW/caqDtdjF0B
 vk/kCKvRFhfHMLU03UKQi0TzWfWatKD4Q278Wtxp9y+9/LiXETu45GOAv1cK4cn/Rf+mqqFO
 +OK4UQxYT9FypMBw2PJw7kDzRYTjS9pbTykDbUHs2bEUqvRnqZdCxNTZTl0MYNE6Kc13w8FP
 sC+6Ju9zrljkvs8EEtIT3T9ndvvfssXOWqwclDKHkCGMPKBPzKKi8D7bKWgSKFB2eVZsxrj3
 FTTW0TnPzmFi3zoT0X2brsK1XnGekAY4tzhIXMPQSD5QdnrawO2KopyhDwym/gvg2/ScHQbO
 n56el9MqbuZ6WVZhO9+EipP9CkAT6HMliCH4u3fMptTv+FsB3E+lO9X+1w5xqFT4SUCQ+Z60
 ni3zJYmsxS9n++DxyAyGgJJsSpOjZmXsF9KJaLDsIJHRGzP8VQO4H+WBhBMoMFqQI6K2egY2
 p3Ek6T9Ly1H+tTf8J4HBsTaH8mANWIoLRvjHDO85O4tTjOxM2zbwUtHn6PKnpV6hps3sJ7hn
 NwJULAJDTTd99sGDV4jB9sfOpx6GDApi7iWiIgP/3Xs9HHs
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:V3fa3620rFXK5Ja1bapL7gqjBGUkLtp133Aq2lEZdPUnSL3jqy
 nIpoVk6faUskdvZJhEo7q90ca7MBfhHPJOkOss1PKZLXXbUQiTXeZfBOnZsl7d8kTFn4Y3tZ
 uIMZIOc+EYa2IK9foSiDPYLz9K+qj/zEnHv5ai854gd3ANV4hQqyl8TiiUe3cYeOCEP/YE/V
 ini/au41ebCBEqhw2AaEU4Yw==
X-Talos-CUID: 9a23:Y4maU2zn8B/XgWdBMOrnBgUJQ/l7X03+wUzaYH6kN35jbaK+FkKPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A62tUWw+JCQl4CwWJd1POQwmQf8U30+O+NVknrY8?=
 =?us-ascii?q?H5sSOOiVXNTGCgB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,304,1763420400"; 
   d="scan'208";a="264575538"
X-MGA-submission: =?us-ascii?q?MDHQy2YeGHham0zPZ3lUt7LKd4KWjl0MLPL0L3?=
 =?us-ascii?q?ZxFiA4RcG3+ojDSCA2i4xtp1qoauLhNS1KvzrsWTVRNFRUE7Qqsg0WFg?=
 =?us-ascii?q?EEGhTWMv7Bw/mlZJwoYcvWtSrHzEsxy40fmiQ4Qi/fR9OdOZ/SQM//Q4?=
 =?us-ascii?q?Gof9hxBTg2pQxMMapqQciRaQ=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 08:12:41 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2AABB60121;
	Sun, 22 Feb 2026 07:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819E6C116D0;
	Sun, 22 Feb 2026 07:12:39 +0000 (UTC)
Date: Sat, 21 Feb 2026 23:12:39 -0800
From: Kees Cook <kees@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>, Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Message-ID: <202602212306.BC7A8E8F@keescook>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-5-kees@kernel.org>
 <20260222041324.GA10695@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222041324.GA10695@sol>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion
 script
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3309
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/dNy5-VItQmcA3EQGlp3ohg>

On Sat, Feb 21, 2026 at 08:13:24PM -0800, Eric Biggers wrote:
> On Wed, Dec 03, 2025 at 03:30:35PM -0800, Kees Cook wrote:
> > Finds and converts sized kmalloc-family of allocations into the
> > typed kmalloc_obj-family of allocations.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Julia Lawall <Julia.Lawall@inria.fr>
> > Cc: Nicolas Palix <nicolas.palix@imag.fr>
> > Cc: cocci@inria.fr
> > ---
> >  scripts/coccinelle/api/kmalloc_objs.cocci | 109 ++++++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci
> 
> Is there a way to reproduce commit 69050f8d6d075dc using this semantic
> patch as claimed?  I spend a while installing the latest version of
> spatch (which was quite hard to do due to all the unusual dependencies),
> but it complains that no rules apply:
> 
> $ /usr/local/bin/spatch --sp-file scripts/coccinelle/api/kmalloc_objs.cocci --dir . --in-place
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> SPECIAL NAMES: adding u8 as a type
> SPECIAL NAMES: adding u16 as a type
> SPECIAL NAMES: adding u32 as a type
> SPECIAL NAMES: adding u64 as a type
> SPECIAL NAMES: adding __u8 as a type
> SPECIAL NAMES: adding __u16 as a type
> SPECIAL NAMES: adding __u32 as a type
> SPECIAL NAMES: adding __u64 as a type
> SPECIAL NAMES: adding uint8_t as a type
> SPECIAL NAMES: adding uint16_t as a type
> SPECIAL NAMES: adding uint32_t as a type
> SPECIAL NAMES: adding uint64_t as a type
> SPECIAL NAMES: adding uchar as a type
> SPECIAL NAMES: adding ushort as a type
> SPECIAL NAMES: adding uint as a type
> SPECIAL NAMES: adding ulong as a type
> SPECIAL NAMES: adding __le16 as a type
> SPECIAL NAMES: adding __le32 as a type
> SPECIAL NAMES: adding __le64 as a type
> SPECIAL NAMES: adding __be16 as a type
> SPECIAL NAMES: adding __be32 as a type
> SPECIAL NAMES: adding __be64 as a type
> SPECIAL NAMES: adding wchar_t as a type
> No rules apply.  Perhaps your semantic patch doesn't contain any +/-/* code, or you have a failed dependency.  If the problem is not clear, try --debug-parse-cocci or check whether any virtual rules (e.g., patch) should be defined.

I'm running:

$ spatch --version
spatch version 1.1.1-00467-g578998d7826c compiled with OCaml version 4.13.1

Running Coccinelle scripts is normally done with the coccicheck target:

$ make coccicheck V=1 MODE=patch COCCI=scripts/coccinelle/api/kmalloc_objs.cocci

-Kees

-- 
Kees Cook
