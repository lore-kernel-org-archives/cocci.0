Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EEFC27C55
	for <cocci@archiver.kernel.org>; Mon, 10 Jun 2024 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CHO11UP0YLqto9FHDymrggcQveGKcZfy5CyAXW9famo=;
  b=NtUgvzEe9a4COHJHKteOZr89ec82LQBSkZz0dJQBYT7RGKv1GF/YMhji
   49U6Sm4owlj++aZ201/r/nhLWcdy53p5GU72YqQQwWgqIul/0j/r2IQXo
   XSuxUhT/ksuCFkz0YWVU5lb/mS0vbbpsB0oZZYneXVN8s9LLJ5I+VI9Ov
   8=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.08,227,1712613600"; 
   d="scan'208";a="169825990"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2024 11:42:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3DB98E0CD4; Mon, 10 Jun 2024 11:42:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3C11CE0035
	for <cocci@sympa.inria.fr>; Mon, 10 Jun 2024 11:25:56 +0200 (CEST)
IronPort-SDR: 6666c6a3_zAtV1T5xUihQSUNGw3OoGSMpNNDLWH9GGEDaiO8EkdImfWA
 czRr+OSwO0Xxk04bkTHCpmBwkVrqBm/JMfECdQg==
X-IPAS-Result: =?us-ascii?q?A0GMAwClxWZmfRAmd6hagQmBT4JEgVU0BwhIhFaIfIhuA?=
 =?us-ascii?q?54MgX4PAQMBDUEBAgQBAQMEhH8CiGcgBgEEMgcOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QgBAQUBAQECAQECBAYBAhABASQ8J4V0DYJngR+BJgEBAQEBAQEBAQEBAR0CC?=
 =?us-ascii?q?GEBHgEBAQECASMEGQEBNwEPCxQEAgImAgJWBhOFQiMDrSJ6fzOBAYIMAQEGg?=
 =?us-ascii?q?mfZNoFjCYEaLogxAYFZhAWEXkKCDYJQgW8+hEODW4JpjyyJTGGCG4kAfyYLQ?=
 =?us-ascii?q?1uJRQlLfRwDWSECEQFVExcLPgkWAhYDGxQEMA8JCyYqBjkCEgwGBgZZNAkEI?=
 =?us-ascii?q?wMIBANCAyBxEQMEGgQLB3aBcYE0BBNEAgGBN4lxDIMvKYFJJ4QaS2yEAoFrD?=
 =?us-ascii?q?GGDSYUpgRCBPoFmAYNUUYFKHUADC209NRQbrCA+BgJ6CglMDyFIZrE1kkSCQ?=
 =?us-ascii?q?YQdgWKgHIFNqGyYZakKgWwKKYFcMxoIJgqDIk8DGQ+WdMdLRDI7AgcLAQEDC?=
 =?us-ascii?q?YVEAYNdgUgBAQ?=
IronPort-PHdr: A9a23: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
 IcSS7hdTxozG+9IUixY
IronPort-Data: A9a23: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
 J8ve1aw3g==
IronPort-HdrOrdr: A9a23:CV8Ha6D1DYG0WIHlHemF55DYdb4zR+YMi2TDGXoRdfUzSL39qy
 nOpoV/6faQsl0ssR4b+exoVJPufZqYz+8X3WBzB8bFYOCFggaVxehZhOOJ/9SjIVydygc378
 tdmsZFZuEYQWIK6vrS0U29G9M/yMKKtKuhlu/X1B5WPHhXV50=
X-Talos-CUID: 9a23:X+k0TGNR47O/xO5DeQo493EFNfgeUz773U/yPRWKV09gV+jA
X-Talos-MUID: 9a23:/ZLYPQtvZE3Scpz9yM2nqwxYZOBX7amUUkEHy5hcupWUKgJtJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,227,1712613600"; 
   d="scan'208";a="89260247"
X-MGA-submission: =?us-ascii?q?MDF8g2FWU35QNFBqZBA8uklna27QDn4+svS50j?=
 =?us-ascii?q?A0+ApoGeiF6/XLkFR/1FtSgtYz8vKzNjMlETbUvRzdYBUo9n+0xa5K2j?=
 =?us-ascii?q?1FC9lXOzxpSCMhStOEYtdM8CK5g+WvTq03gQEVVclJ/6766fTHsMG1c3?=
 =?us-ascii?q?ekU5oiNurQ8GTfvWG9iQZt2w=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:25:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CHO11UP0YLqto9FHDymrggcQveGKcZfy5CyAXW9famo=;
	t=1718011555; x=1719221155; b=Ony1AbSMC/MPCWpNhYDVhui43MY4Zv3dtMEAesiY+GL0RFH
	0x0aB04uOhqzdamMGvi2rIVD6CIJYP4VGdBw+n07aii6PlpxnNyuVWlXNexu509FK6pVOU3I7LBEz
	glWemhQ1iKWWN54QiojP6Tlo269nQg6xBzX+Rote+zZtQUHMHpLV0ReyLUafbRrMCYFNQD58tsx+6
	rYjg7WSineDCqq8kXrhPvj2IgWUIPS+kGiAJSwyk2VrLPOQsplTqFG7RVTbLiI/qppfoNKvCiSV78
	+IeRjir0oE4qksxp6zxnBenXWRJwDhNazuCdBjNbJ/SU5s3wHYe88enjSsQpzeow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sGbHm-00000006V3h-0w72;
	Mon, 10 Jun 2024 11:25:54 +0200
Message-ID: <51e451891bff494df7040c5e5724c68f325411d3.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Date: Mon, 10 Jun 2024 11:25:53 +0200
In-Reply-To: <aebf2712-a3cb-1b53-c173-1a6fcc821f51@inria.fr>
References: 
	<9c981025522250c68c8cca83a2fa3e32097bae3b.camel@sipsolutions.net>
	  <f0ad5ab5-d3ea-ac6-3c6e-dd1be07f4e41@inria.fr>
	 <a01e8d2f2f5d90373fa094a8514ea2f5736db8dd.camel@sipsolutions.net>
	 <aebf2712-a3cb-1b53-c173-1a6fcc821f51@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] strange braces behaviour
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 1790
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/51e451891bff494df7040c5e5724c68f325411d3.camel%40sipsolutions.net>

On Mon, 2024-06-10 at 09:04 +0200, Julia Lawall wrote:
> commit 7eded3b97dadb1f0f4ed29d6c56856647c04b656
> Author: Julia Lawall <Julia.Lawall@inria.fr>
> Date:   Sun Jun 9 16:07:57 2024 +0200
>=20
>     should use the non fake end node when after is attached to it; that i=
s
> part of the code

Thanks.

I built master (commit ac9af0e8b7c76341de1999389ce285b72ebaf81b) now.

> > Also, I'd like to check against the similar issue I had with removing a
> > whole switch statement ("-switch(...) {...}")
>=20
> Maybe it will indeed fix this as well.

So first of all, it doesn't even parse what I wanted:

@@
@@
 sta_link_apply_parameters(...,
-                          struct link_station_parameters *params)
+                          struct station_parameters *params)
{
...
-u32 link_id =3D params->link_id < 0 ? 0 : params->link_id;
+u32 link_id =3D 0;
...
-bool changes =3D ...;
...
-switch (mode) { ... }
...
}

but this isn't supported:

minus: parse error:=20
  File "...", line 13, column 17, charpos =3D 295
  around =3D '...',
  whole content =3D -switch (mode) { ... }

but I guess that's fair.

But trying to do this:

@@
@@
 sta_link_apply_parameters(...,
-                          struct link_station_parameters *params)
+                          struct station_parameters *params)
{
...
-u32 link_id =3D params->link_id < 0 ? 0 : params->link_id;
+u32 link_id =3D 0;
...
-bool changes =3D ...;
...
-switch (mode) {
-case STA_LINK_MODE_NEW:
-...
-break;
-case STA_LINK_MODE_LINK_MODIFY:
-...
-break;
-case STA_LINK_MODE_STA_MODIFY:
-...
-break;
-}
...
}


There's a "return -EINVAL" inside the _NEW case in the original code:

static int sta_link_apply_parameters(struct ieee80211_local *local,
                                     struct sta_info *sta,
                                     enum sta_link_apply_mode mode,
                                     struct link_station_parameters *params=
)
{
        struct ieee80211_supported_band *sband;
        struct ieee80211_sub_if_data *sdata =3D sta->sdata;
        u32 link_id =3D params->link_id < 0 ? 0 : params->link_id;
        struct ieee80211_link_data *link =3D
                sdata_dereference(sdata->link[link_id], sdata);
        struct link_sta_info *link_sta =3D
                rcu_dereference_protected(sta->link[link_id],
                                          lockdep_is_held(&local->hw.wiphy-=
>mtx));
        bool changes =3D params->link_mac ||
                       params->txpwr_set ||
                       params->supported_rates_len ||
                       params->ht_capa ||
                       params->vht_capa ||
                       params->he_capa ||
                       params->eht_capa ||
                       params->opmode_notif_used;

        switch (mode) {
        case STA_LINK_MODE_NEW:
                if (!params->link_mac)
                        return -EINVAL;
                break;
        case STA_LINK_MODE_LINK_MODIFY:
                break;
        case STA_LINK_MODE_STA_MODIFY:
                if (params->link_id >=3D 0)
                        break;
                if (!changes)
                        return 0;
                break;
        }
...


which spatch leaves around:

@@ -1814,113 +1814,93 @@ enum sta_link_apply_mode {
 static int sta_link_apply_parameters(struct ieee80211_local *local,
 				     struct sta_info *sta,
 				     enum sta_link_apply_mode mode,
-				     struct link_station_parameters *params)
+				     struct station_parameters *params)
 {
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_sub_if_data *sdata =3D sta->sdata;
-	u32 link_id =3D params->link_id < 0 ? 0 : params->link_id;
+	u32 link_id =3D 0;
 	struct ieee80211_link_data *link =3D
 		sdata_dereference(sdata->link[link_id], sdata);
 	struct link_sta_info *link_sta =3D
 		rcu_dereference_protected(sta->link[link_id],
 					  lockdep_is_held(&local->hw.wiphy->mtx));
-	bool changes =3D params->link_mac ||
-		       params->txpwr_set ||
-		       params->supported_rates_len ||
-		       params->ht_capa ||
-		       params->vht_capa ||
-		       params->he_capa ||
-		       params->eht_capa ||
-		       params->opmode_notif_used;
-
-	switch (mode) {
-	case STA_LINK_MODE_NEW:
-		if (!params->link_mac)
-			return -EINVAL;
-		break;
-	case STA_LINK_MODE_LINK_MODIFY:
-		break;
-	case STA_LINK_MODE_STA_MODIFY:
-		if (params->link_id >=3D 0)
-			break;
-		if (!changes)
-			return 0;
-		break;
-	}
+	return -EINVAL;
+	return 0;
+}

and it also has the closing brace here, so it somehow leaves a closing
brace too much also in this case, even with the fix.

So perhaps not the same issue?

(I worked around it for now by leave the switch/case/break instead of
removing, so it's kind of just a dead switch after the change, doesn't
do anything but structurally still exists)

Thanks,
johannes
