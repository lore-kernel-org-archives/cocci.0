Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74EBC25B78
	for <cocci@archiver.kernel.org>; Tue,  4 Jun 2024 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VwtOeHpoHbJyJoUoileyPdSRLURhWXeyLKGOZCtf02Q=;
  b=O2Mwu+H0SHBPAIYcfRKmbwsfFWcE4upw5TeiPaYw7p47n0UQq2a20EVa
   oPEvVElVHKBD66HTl8EbTsPHU3rh6ycDlPhWjmY3n0pn0YRwrZ0qHXosb
   mdJp/ftAI4HjaCQ58Yv2U0F9PiQowOt3ykbww0MPxTAvjpr3ZERBVu2/c
   A=;
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
X-IronPort-AV: E=Sophos;i="6.08,214,1712613600"; 
   d="scan'208";a="169022903"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jun 2024 22:16:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3482EE013D; Tue,  4 Jun 2024 22:16:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A2BECE0035
	for <cocci@sympa.inria.fr>; Tue,  4 Jun 2024 22:08:36 +0200 (CEST)
IronPort-SDR: 665f7444_osh83yFXe1lPCs9uumKan+sknEPZRbXMqKKXdA0uOXnwuKb
 Y9PaoJY6wnyZ79JnkcCeMSO7Ey5QfVfN0USvdew==
X-IPAS-Result: =?us-ascii?q?A0HmIwDCc19mfRAmd6haGwEBAQE8AQEBAwMBAQECAQEBB?=
 =?us-ascii?q?QEBARWBTwKCQoFVNAcISIRWiHyoeg8BAwENFBMaAQIEAQEDBI1kIAYBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEkPCeFdA2CYIEmg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAghhSQQZAQE4NAImAlIMhXgDsT9/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k2gWMJgRouAYMKhSYBgVmEBYUggg2NG4JpmWCCHIkGfyYLQokkCYFIHANZI?=
 =?us-ascii?q?QIRAVUTFws+HQIWAxsUBDAPCQsmKgY5AhIMBgYGWTQJBCMDCAQDQgMgcREDB?=
 =?us-ascii?q?AYUBAsHdYMlBBNEAgGBN4lwgzuCHYQcS4RwgUUmDGGKBoFBgWaDXlkdQAMLb?=
 =?us-ascii?q?T01FBusRUeBBoEuIZNxsiWEHYFioByBTahpmGSpCoF7JC6BLjMaCCYKgyJPA?=
 =?us-ascii?q?xkPji0WiDHEDUQyOwIHCwEBAwmFRAGDXYFIAQE?=
IronPort-PHdr: A9a23:eehN1RJtBshKfHMlYdmcuOttWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFtLM33QOCBN6Ko9t/yMPo8InYGlY8qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebxtMiTanf79/K
 Bq7oQrMusQYhYZpN7o8xAbOrnZUdOtawn9lK0iUkxjg+Mm74YRt8z5Xu/Iv9s5AVbv1cqElR
 rFGDzooLn446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXjSi8
 rtrRRr1gyoJKzI17GfagdF2galGohyuugZ/zpbXbo+INPRwYK3Tcs8VS2VPUclcTDBBApqmY
 ocTE+YMJ+RVoo/grFUOtxu+AgysCfvrxD9Phn/5x6s60+I/HgHdwQctAswBsG7brN7oM6oSU
 +e1zKnSwjXFafNZxyz95ZPTchAgufGMRrVwcc7MyUkzFgPFiVOQqZf/MzOTyOsNr3GW4ux9X
 u2gl2ApsRt+oiSzxsgykInJgJoYxkzK+Chlw4s4O8O1RUx1b9O6HpVdtz2WO5V3T84hXW1lu
 Tg3x78EtJC1ciUExpcqyRHdZvGEbYWE/hPuWfuNLDp+mXlre6q/ig6v/UWhyeDwTNS43EtOo
 yZfnNTBtWoB2wHS58WBV/Bw4EOh2SuU1wDP9O5EO106lavaKpE/2rM8ipweulnZECDsgkX5l
 qqWe10k+ue27+TnZa3rpoSdN49skQH+NaAumtGjAeQ5NQgOWXOb9f661LL94U31WLRKjvson
 anFqJ3WOMUWq62jDwNIz4ou7wyzAjml3dgCgHUKLUpJeBedgIjoP1HOLur4DfC6g1m0kjdrw
 PDGMafnApXLMHfDi6zsfa18605E0wozytRf549ICrEAJ/LzXFTxuMbeDhAnLwy42+DnB85l2
 YMERW2PGrOZML/VsVKQ++4jO/OMa5MNuDbhN/gl4ObjgmM+mVABYaap3IAaaGu4H/RjO0WWe
 2DggtYHEWcQvwoxVvbmiFOYUW0bW3HnVKU37TBzXImhBozCboGrmr2ImimhSM54fGdDX3KLE
 X7ucYifE90Bci3ads1mkjUCU7W6Y5QgzQqpsBLmyr1hNazS9zFO5sGr78R8++CGzUJ6zjdzF
 cnIiwllLklxl2IMHXot2bxn5FZ6wRGF2LR5hPpREZpS4elIW0E0L82U1PR0Xvb1XA+JZdKVU
 BC+WNzzAzYxR9Q3zsQmeEdlANKmkwzC2CyxRbkYi+/DH4Q6p5rVxGO5PMNh0zDD3aglgUMhR
 55NMm2vgKhy7CDIBpbSlEGEi6etc79a2iPRpy+Y1WTbhEhDS0ZrVLndG3ASYkyDtdPi+kbLV
 KOjE5w8MxNazsqfNqpNbMavi1haLBv6EPLZZW/522K5BBLSg6iJcJKvYWIWmiPUFEkDlQkXu
 3eALwk3QCm78SrYC3R1GFTjblmJk6E2oW6nTkIy0wCBblFwn7uz9BkPgPWASvQVlrsasSYlo
 j9wER6zxdXTQ9aHogNgeu1bb7ZfqB9F0mLQsQpwJbS7Lrh5gVoDbwVwuVio0RhrS81BncUss
 HI23V9qM6vLtTEJPzic3J32JvjWMjyrokDpMveHnAqOlo/IqcJtoLwipl7uvR+kDB8n+nRji
 ZxO1meEo4/NB0wUWI7wVUA+8157oavba28z/dCxtzUkPK+qvzvFw99sCvEiz0PqfdBfOaWCG
 RTaCMwCHM+qNfArnF6yKBQJIKoBkcx8d9PjbPaA1KOxaaximzKvi2JK+6hm01qX8C5hVu/P2
 Y1DxfyElFjiNX+0nBKqtcb5nppBbDcZEz+kyCTqM4VWY7V7YYcBDWrGz9Sf/txlnNatXndZ8
 ATmHFYawIqzfhHUaVXh3ApW3EBRoHq9mCL+wSYm2z0uq6Oe2mTJzYGAPFIFPW5CQm9vln/3I
 JCviNQHQEmvaRNvkha5rUr33KlUoq1jInKbGBkYOXGvfic5Au3p6PKLeKstoNswvD9SUfigb
 FzSUbP7rxYAkmviE2ZY2DEnZmSvs5T9kQZ9jTHVJ3JyoXzFPMBokE6BtJqFHK8XhWpAHXcr7
 FufTkKxNNSo49iOwpLKs+TkEnmkSoUWay7gi4WJqCq842RuRxy5hfG63NP9Qm1YmWf20cdnU
 SLQoVPyeI7ugu64NuJueE9lH3fn6tJhHYVjjoo3gopW33UGzMbwnzJPgSLoPNNX1LirJngKR
 TcNxdPOyBPkwFZkKm+VxoX/TTObz9crNLzYKisGnyk66c5NEqKd6rdJyDB0rlSPpgXUefFhn
 z0ZxKhm+DsAjuoOogZo0jSFD+VYAxxDJSK13UftjZj2vOBNaW2oa7T1yEdugYXrEuSZug8FE
 H+xf4dqWCZ06o8X3Evk6HTo8cmkfdDRaYhWrRiIi1LaiOMTLpstl/0MjC4hOGTnvHRjxfRpx
 RBp2Ji7usCAJQAPtOqhBQVEMzTue84J0irslb1ZmtuK3oepBdNnFylDUJbzTP2uGS4frry+a
 VbISWRt7CzLX+OBVQaEjSUu52rCCZWqK22aKDECwNNuSQPcbE1TjQYIXSkry540Egf5jMflc
 Up/+nUQ/guh9EsKk7s5cUKvFD6B92LKIn8uRZOSLQRb9FRH7kbRa4mF6/5rWjtf9dunpRCML
 WqSY0JJC3sIUwqKHQOGXPHm6N/e/uyfHuf7IeHJZODEq+teXvGOyImHyYp+5DGIK9mOOX95S
 fs2xgAQOBIxU9ScgDgJRyENwmjVaNWHoR6n5iBthtu+6O/sXB/z5IyJEP1UPMklqHXUye+Tc
 uWXgih+MzNR0JgBkGTJxLYo11kXkyhydjOpHOdIpWvXQanXgKMSEw8DZnY5Kp5T96xllFooW
 4aTmpbv27V/lPJwF1pVSQmrhJSyfcJTa2j1MUOPQU+PMP7uzdzj2MDveqS4VKFRi+NP8Ru9p
 WTCe6cMFi+CjyLuUw2zMOZKl2edMQAM4elVlz52CHD4S9b7dhy8NsQxizAqk+Vcuw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:s6e0+6Gx4bl6TA0MpLqE78eALOsnbusQ8zAXPidKOH9om62j9/
 xG+c5x6faaslcssR0b9uxoW5PwJE80l6QZ3WB5B97LNjUO01HFEGgN1+XfKnHbak/D398Y0a
 9kbaBkBJn6BUtzhd2S2njdL+od
X-Talos-CUID: 9a23:0eEDMm5hwSGB2sMR3dss9EBKAeAlfiLk9Xb1ZF+YE2M2TL6URgrF
X-Talos-MUID: 9a23:3y3O3ATzY3LdMlA4RXTSogp7KN9B456+VkJQnbAcsczePAhvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,214,1712613600"; 
   d="scan'208";a="169022342"
X-MGA-submission: =?us-ascii?q?MDGftFYFPvo0nac5b8dWwjB2TkY5yL1XCcOhA9?=
 =?us-ascii?q?EdmRoGu1CrBLwWUMdtMZxOEu5Ga48/HgI0dlRBgRl91KIlftZWhjMl+2?=
 =?us-ascii?q?7+rsB7hR89PuiaDtTUN9cW+NWcmm48KKI69eflMZF8Ge7ysj9Sl/1HMO?=
 =?us-ascii?q?H4Eezf97JhER7lYpqcFHmOFg=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:08:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=VwtOeHpoHbJyJoUoileyPdSRLURhWXeyLKGOZCtf02Q=; t=1717531716; x=1718741316; 
	b=Hf2x11qV0ZU+YbaS7gkv3ZtOcS+yGC+4luz4G62V6H2VCUnBKPAydjjIGfrewJJd6ATHB9y7AEs
	uXS5GuT5ZKBcCdpVWR5SybmG7TfP3Dv8DowYbc91V1J0br9AGYo5m8GX6ebXW7xjPmyBLuT835XKe
	EliL31Y8FpwSh0YIiF2qotZCYwARdKoKLdYe4WmN1+htC+Vwj1Fn/cf2HA1kKcf8IusuQo0mP/0LB
	lUvzEjfahfov9OXTNZmrRWuFxj3iwa3WCux3oM5wQWDMkC5TvZUcybv4CJKjm87ZDTP0Dn+A0QzHK
	WpR9fHSRU5razurg3qjBy3/+4qZ9+aHji40g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sEaSQ-0000000CrM7-0zyX
	for cocci@inria.fr;
	Tue, 04 Jun 2024 22:08:34 +0200
Message-ID: <9c981025522250c68c8cca83a2fa3e32097bae3b.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: cocci <cocci@inria.fr>
Date: Tue, 04 Jun 2024 22:08:33 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] strange braces behaviour
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 1776
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/9c981025522250c68c8cca83a2fa3e32097bae3b.camel%40sipsolutions.net>

Hi,

So I've been trying a few similar things, but today we came across this
one:

Given this function from the current Linux kernel:

void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_id)
{
        struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(vif);
        struct ieee80211_link_data *link;

        if (WARN_ON(link_id >=3D IEEE80211_MLD_MAX_NUM_LINKS))
                return;

        rcu_read_lock();

        link =3D rcu_dereference(sdata->link[link_id]);
        if (WARN_ON(!link)) {
                rcu_read_unlock();
                return;
        }

        wiphy_work_queue(sdata->local->hw.wiphy,
                         &link->color_change_finalize_work);

        rcu_read_unlock();
}


Applying the following spatch:

@@
identifier func =3D~ "ieee80211_color_change_finish";
@@
func(...)
{
-...
}


leads to

void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_id)
{
}
}


with
spatch version 1.1.1 compiled with OCaml version 5.0.1+dev0-2022-12-15
and also with
spatch version 1.1.1 compiled with OCaml version 4.14.1


Trying this spatch:

@@
identifier func =3D~ "ieee80211_color_change_finish";
@@
func(...)
-{...}
+{}


works fine with
spatch version 1.1.1 compiled with OCaml version 5.0.1+dev0-2022-12-15

but *fails* with
spatch version 1.1.1 compiled with OCaml version 4.14.1

saying

EXN: Failure("rule starting on line 1: already tagged token:\nC code
context\nFile \"./test.c\", line 3, column 0, charpos =3D 76\n  around =3D
'}',\n  whole content =3D }") in ./test.c

which is almost stranger than the left-over closing brace, especially
the difference between those two spatch versions I have?


Any thoughts?

(I have a similar situation with removing a whole switch() statement
from the code, but I'll leave that for later)

Thanks,
johannes
