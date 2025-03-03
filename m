Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434A4C282DE
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RM4t6/4+DfJIivINfIk3MbFXwHwlUVBVtvo2tKQ7FAQ=;
  b=BvleC2rVXKV4ZlzFArrJw/O3NSHQBEVJsFcokgZdBnSKRTrUhW8La5fX
   O5kS6cWQPmmBwUsSDVdwkjOc6N1jcSHB75OlqhpDBZ9HFN51QQ4J468Wo
   tci36s/7dYO8ph/xiVvDa8LTOjrusMd1M7aI9X6FEaFli0g01F5Xr7W2B
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069356"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7BDD0E0E4D; Tue,  4 Mar 2025 10:58:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CAAFAE0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 07:25:23 +0100 (CET)
IronPort-SDR: 67c54b53_KIiZJHB8IRB3UjfuDYYZak1UTDma2FH/HhSNp5i0rfHF4Jb
 2OsUENAXitTe/fCkscqPeP1eYLWixEJrYEBRD2A==
X-IPAS-Result: =?us-ascii?q?A0EDAADdScVnjw+jxsBaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAQGCQoFWNAQLSIRWiB2HMoIEHQOBE50BgUA+D?=
 =?us-ascii?q?wEDAQ1BAQIEAQEDBIIMgmwIAosVAh4GBjAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhXsNSQEBBAsBggcBgSReBwk4AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBHQEBAQEDIwQLAQ0BAR4ZAQ8LF?=
 =?us-ascii?q?AEDAgImAgIQRgYTgwKCZQOtdHp/M4EBggwBAQbcIIFlCYEaLgGFa4JjAYVSh?=
 =?us-ascii?q?BZ6Jw+BVUSBFYJyBzE+iB6CaYNuLgGDPahYUnt4LAFVExcLBwWBKUgDgQ8jD?=
 =?us-ascii?q?4EUBTRBOoILaUk6Ag0CNYIeJVeCK4IXgjeEPYRAhVKCEYFdAwMWDwGDH3cch?=
 =?us-ascii?q?HyEah1AAwttPTcUG6IxOoNPcgFSOxwwNIFAKQ2Sb4NRr1I0B4QegV0GoDKqV?=
 =?us-ascii?q?ph9qTGBZzqBXHCDN08DGQ+OIQwNCRaDQshWRTICOgIHAQoBAQMJhUYBAYd1N?=
 =?us-ascii?q?YIqgUsBAQ?=
IronPort-PHdr: A9a23:MlpyJBWOapVKTUCILDbDU6XQFhnV8KzFXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBt+ds6oP27uN4ujJYi8p39WoiDM4TNR0TRgLiMEbzUQLIfWuLgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL58M
 hm6txndutUZjYZhLqs8xB/EqWZUdupLwm9lOV2ckxHg68mq+5Jt7zpesO87+c5aVqX6caU4T
 bhGAzkjLms4+s7luwTdQAWW/ncTXXkYnRROAwje8RH1RYzxvTfgtup8wyaVI8v7Rq0pVDu47
 qdrTBjoiDobNzM87WrahNB8gL5drRm8vBF03ZLab5+JO/p/ZqPdfM0VRWxdXsZKSidNBpqwY
 5YTA+YdOOpVqZT2qVkTohukHQSiCuPhxCFWi3Hr3qM63esuHh3b0wIvHd0Dq2jUodbvOasOT
 ey50KvFwDPeZP1Wwzf9743Ifwgmr/GNQb1wcdDeyU0yHA3YgFSQqJbqPy+W1uQKvWmb9OlgV
 eOygGMgrgFxoySgxsc2hYnNnI4V0V7F9SRjz4YpJt24T0B6YcWnEJtRrCyaM4p2QsU/Q2Bno
 io6y7sGuYKlcygO0pgo2xnfa/mefoWO/xnsW/qfLy1ii3J5ZLKwmQyy8U64x+DiVMS5zUtHo
 zRYntTOtX0A1gHe58iIR/Vy/kmsxDWC2g7R5+xAPU06mq7WJoIuzLA+iJceskfOECDrlUj1k
 KKbcFgv9Ouw6+n/f7nrooGQO5Vphgz6MakigNGzDOU2PwQUQmSW+eKx36D98E39XbVKleE2n
 bfDsJ7HJMQap7C2DhdJ3osl9h2xFS2p0M4CknkCNF9FeAyIj4zuO1zWJfD4Au2wg1G2nzdqw
 /DKJLzhApPRLnfdlLftZ6py60lZyAYrzNBf4YxbCq0ZLf7uXkL9qsbUAgI9PgG32errFdRw2
 40EVW6SAqKVKKbSvkWJ5uIrLemMfogVuDPlJvgg5v7hkX85lkUZfaWzxpsWZnG4Ee56I0WaZ
 nrtjMwBEWQLvgclSOzqiVuCUSNcZnqoXqI84C07B5yiDYvZWo+th7mB0D+9HpJNfm9GEEyDE
 W/0d4WYXPcBcD+eLtd7kjMYTbihV5Mh1Ra2uQDmzLpoMvbb+iwDuJL41Nl14vXTmgso+Tx1C
 cSdyWCNQHtukmMGXT9llJx49Gl00FSeyuBVh/JCFNpcr6dsWx05KIWa4uh0EdH0VSrec93PR
 FvwEfu8BjRka9M6w9YKK31iGty+jRfcxCmrS+sQlreLDZhy6b3d1mTyINlmyHfu0KgnkklgQ
 81TOGngjal6oVuAT7XVmlmUwv75PZ8X2zTAoSLalTLmVCBwVQdxVf6ARnUDfg7Nqsy/4EreT
 rioALBhMw1byMfEJLEZIsbxgwBgQ/HucM/bf3r3g325UBOJzbOFaMzxZGQUwCbaF1MHkigX/
 HCbJU4/ADuspyTVCzk9XUn3bRbK9u9z4Gi+UldyygiLa0N70L/g/x8ehfWYDegM37sYuyA+s
 DZ1NFK82c/GTduGuwdlOq5bZIB1+09JgETesQE1JZm8N+Zii1oZJhxwpF/r3g5rB59olMcjq
 XoryExzL76V1BVKcDbwMYnYHLrRJyGy+Rmub/WTwVTCyJON/b9J7v0kqlLltQXvF0w48nwh3
 cMHm32bro7HCgYfS/eTGg4+6gR6qrfGYyI8+5Kc1HtiNrOxuyPD3NRhDfUsyxKpddNSeK2eE
 wq6H8ofDsmoYOsk/jrhJhcFN+Bb8OgvIMKva/iBx7WoPc5knTS7nSJG5pxw1gSH8C89Au/E0
 pAZwu2JixOdXmSZ7h/pucT2lIZYIDAKSzPuk269Vd4XP/MpO99WWgLMa4Wty95zhoDgQStd/
 V+nXBYd3dOxPAGVdxr71BFR0kIepTqmnzG5xnp6iWJMzOLX0SrQzuDlbBdCNHRMQTwoiFbnI
 YGwycsFXUG0bA82jxikzUL7wbVL4qV5M2TXB0xPemKlSgMqGrv1rbeEb8NVvdktsC5XWeD6e
 k+bQ6L+pAQB0CLLG2pY2SB9dje2t5G/lBt/wjH4Tj47vD/Sfsd+wg3a7drXSKtK3zYIcyJ/j
 CHeGlm2O9TBEcy8sZDFv6j+UmugUsYWaiz31cabszP942R2ABq5lvT1m9v9EAF83zWpn99tH
 T7FqhrxeOyJn+yzLP5nc090BVT999syG4dwlZE1jY0R3n5Sj4uc/H4Om2P+edtB3qe2YH0IT
 D8Ni9nbhWqtkEhiJXKAw8TiSXSU3shmeMK5Y0sS2yQg/4ZLDruZ6PpPmi406lu0oATNYORsy
 zIUyP8g8nkf0IRr8EImyiSQBKxXHFENZH220U3Zv5bn8v4RPTv8FNr4nFBzlt2gEryY9wRVW
 XKiP4wnATc19cJndlTFzHz07IjgPtjWd9Ma8BOOwHKix6BYLow8kv0SiG9pI2X46DcgyuU7h
 Bgoxo67tZSELHp2/6ORBh9eKy2zZsUP9zWrhqFb1JXzvcjnDtB6FzMHUYG9B/epGzIbsbL8K
 AeHDD47tWyYGJLbHAmC+AFnqW7CF9agMHTddxx7hZ1yARKaIkJYmgUdWj43y4U4Gg6dz8vka
 E5l5zoV6zYUszNqzeRlf1n6W2bb/0KzbyssDYOYNFxQ5x1D4EHcNYqf6PhyFmdW5M/pqgvFM
 WGdawlSaANBEkWZG1DuOKWv7tjc4qCZAOS5Nf7HfbSJr6RXSf6JwZul1oYu8SyLM42DOXxrD
 vtz3UQmPzgxA8PChzAGUDAajQrIYMeerRa4vCxxss27tv/sXUOn5IeCDadTLcQ6+x2yhvTmV
 abYjyJ4JDBEk5IUkCaZkv5GjQ5U0n81MWDwQtFi/WbXQandm7FaFUseYiJ3b45T6r4kmxJKI
 Yjdg8/00bhxirg0DU1EXBrvgJLMB4RCLmejOVfAHEvOOq6BIGiBxsD8Yaq4D6ZPjexItBqvo
 jWaO0viOCmT0TjvSx2rd+pLiWvIWX4W8JH4aRtrBWX5GZj+bQanNdZskTAs6bg7j3bDNGpaM
 D5gfkcLpbqVp3A94L03CylK6XxrKvOBkiCS4rzDK5oYhvBsBzx9i+NQ5HlSI1R96CBCWewzm
 S3Oo9ooqFajwLHnIt9PVBtItyYNhYSXsEEkMqLcpMEosZfs+R0E6GyRD1ILocdoDpvkvKUCk
 rDy
IronPort-Data: A9a23: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
 k8bi4dAD656F5DTVWYUVwoVvJJJ
IronPort-HdrOrdr: A9a23:jB+Hc6ChvTid17LlHelq55DYdb4zR+YMi2TDGXoBMCC9Vvbo6P
 xG+85rqyMc6QxhJE3I/OrqBEDuewK5yXcY2/h3AV7mZniWhILKFvAe0WKB+UyaJ8SWzIc0u9
 YET0E9MqyLMbEQt7eD3ODXKadH/PC3tIqTqaP1yXBrQQt2a6dmwTtYJ2+geCxLbTgDL6AUUL
 6H6OR6hxfIQxl2Ui39PAhnYwHEnbGl5fDbXSI=
X-Talos-CUID: =?us-ascii?q?9a23=3Af1WrmGl+Khul2MJIw94P7MyENzfXOXfs4W6LfW+?=
 =?us-ascii?q?HNWQ3c+2pGHS755hblfM7zg=3D=3D?=
X-Talos-MUID: 9a23:YVpVTgRiV0i6J/rvRXT3hRV8C8Fl6p/2DW4XvI8B55jHbQ1JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110450167"
X-MGA-submission: =?us-ascii?q?MDHnYqz3TNARQ6jDsgxyPKkRDtTKTwiIPRFJgV?=
 =?us-ascii?q?O9Yb+yorJcZ4vJkpTQPqsi1AtsLagYvbQGLHe3qh0NoyhdHogLDGuLgc?=
 =?us-ascii?q?DOyRIACjStEWfPY+93VjwwcN8pqDL3CXBw1pT+thOzd+HKuwIYbW90iT?=
 =?us-ascii?q?YDBZNQ/kQUKBwuPkrZe1Mg3A=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.15])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 07:25:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740983123; x=1772519123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QddSmenzJXUSnQaTPXNrQkvUIido0PcI4/XhapFbIgs=;
  b=TnmfRUcVU0vaZaoaALY46jMvWH18DSIk9RJHBhgke8iu7+PE8H8HEt21
   L/I2dx4+IZjZyzB2L78im3siZqPxl2rcPtj5JJ0rJdnsgVoLI1ERNz9iG
   N9zWjreTgSOTetg/N5MRvNHwDzDKJQUnxxceOamWEey43HmS3KYdCqlvk
   GrdbZHYlB8rQKQGnhCmNkMdfIZNEBgfJbaibERdoj/0qj2uVPdBlFZxzi
   PLkFBvRzCfCZ6xh6O8GP+xKe53kCYwOlBUTQOv8e2LW3wowlKqC1Gq5ea
   5UjJApEieeVCCvW7xhO7126Y7oMQzimaNmQkUSe/LmvBwJZ6Sgkr8av7V
   w==;
X-CSE-ConnectionGUID: ph9zbsMBRW+H/btqjGjHCQ==
X-CSE-MsgGUID: Zr2AFNxaSuiEf4pM1B9pcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41966652"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41966652"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 22:25:20 -0800
X-CSE-ConnectionGUID: VhVfEy7fR6607pYneT8zZQ==
X-CSE-MsgGUID: PiQGcvOfTbSSRhc5EXnUYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="123065041"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 22:25:17 -0800
Date: Mon, 3 Mar 2025 07:21:28 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ariel Elior <aelior@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ram Amrani <Ram.Amrani@caviumnetworks.com>,
	Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] qed: Move a variable assignment behind a
 null pointer check in two functions
Reply-To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2502
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/Z8VKaGm1YqkxK4GM%40mev-dev.igk.intel.com>

On Sun, Mar 02, 2025 at 05:55:40PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 11 Apr 2023 19:33:53 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the functions “qed_ll2_rxq_completion” and “qed_ll2_txq_completion”.
> 
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variables “p_rx” and “p_tx” behind the null pointer check.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 0a7fb11c23c0 ("qed: Add Light L2 support")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_ll2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
> index 717a0b3f89bd..941c02fccaaf 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
> @@ -346,7 +346,7 @@ static void qed_ll2_txq_flush(struct qed_hwfn *p_hwfn, u8 connection_handle)
>  static int qed_ll2_txq_completion(struct qed_hwfn *p_hwfn, void *p_cookie)
>  {
>  	struct qed_ll2_info *p_ll2_conn = p_cookie;
> -	struct qed_ll2_tx_queue *p_tx = &p_ll2_conn->tx_queue;
> +	struct qed_ll2_tx_queue *p_tx;
>  	u16 new_idx = 0, num_bds = 0, num_bds_in_packet = 0;
>  	struct qed_ll2_tx_packet *p_pkt;
>  	bool b_last_frag = false;
> @@ -356,6 +356,7 @@ static int qed_ll2_txq_completion(struct qed_hwfn *p_hwfn, void *p_cookie)
>  	if (!p_ll2_conn)
>  		return rc;
> 
> +	p_tx = &p_ll2_conn->tx_queue;
>  	spin_lock_irqsave(&p_tx->lock, flags);
>  	if (p_tx->b_completing_packet) {
>  		rc = -EBUSY;
> @@ -523,7 +524,7 @@ qed_ll2_rxq_handle_completion(struct qed_hwfn *p_hwfn,
>  static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
>  {
>  	struct qed_ll2_info *p_ll2_conn = (struct qed_ll2_info *)cookie;
> -	struct qed_ll2_rx_queue *p_rx = &p_ll2_conn->rx_queue;
> +	struct qed_ll2_rx_queue *p_rx;
>  	union core_rx_cqe_union *cqe = NULL;
>  	u16 cq_new_idx = 0, cq_old_idx = 0;
>  	unsigned long flags = 0;
> @@ -532,6 +533,7 @@ static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
>  	if (!p_ll2_conn)
>  		return rc;
> 
> +	p_rx = &p_ll2_conn->rx_queue;
>  	spin_lock_irqsave(&p_rx->lock, flags);
> 
>  	if (!QED_LL2_RX_REGISTERED(p_ll2_conn)) {

For future submission plase specify the target kernel
[PATCH net] for fixes, [PATCH net-next] for other.

Looking at the code callback is always set together with cookie (which
is pointing to p_ll2_conn. I am not sure if this is fixing real issue,
but maybe there are a cases when callback is still connected and cookie
is NULL.

Anyway, with heaving this check for p_ll2_conn it is good to move
assigment after this check.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> --
> 2.40.0
