From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Aug 2018 15:43:20 +0200 (CEST)
Subject: [Cocci] New release after 1.0.7?
In-Reply-To: <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
 <alpine.DEB.2.20.1808141515280.3371@hadrien>
 <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
Message-ID: <alpine.DEB.2.20.1808141541470.3371@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I'm not sure it's a regression, but I just couldn't get the attributes
> to work with 1.0.6 either with and without Johannes' changes to upgrade
> it to the 1.0.6 syntax.
>
> This is the cocci that doesn't work (which is supposed to work with
> 1.0.6):
>
> https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/tree/patches/0027-genl-const/genl-const.cocci
>
> And, IIRC, this is the file that it's supposed to alter:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/wireless/nl80211.c

With the current version, I get the diff below.  Is it what you expect?

julia

--- nl80211.c
+++ /tmp/cocci-output-11687-71a383-nl80211.c
@@ -48,7 +48,7 @@ enum nl80211_multicast_groups {
 	NL80211_MCGRP_TESTMODE /* keep last - ifdef! */
 };

-static const struct genl_multicast_group nl80211_mcgrps[] = {
+static __genl_const struct genl_multicast_group nl80211_mcgrps[] = {
 	[NL80211_MCGRP_CONFIG] = { .name = NL80211_MULTICAST_GROUP_CONFIG },
 	[NL80211_MCGRP_SCAN] = { .name = NL80211_MULTICAST_GROUP_SCAN },
 	[NL80211_MCGRP_REGULATORY] = { .name = NL80211_MULTICAST_GROUP_REG },
@@ -12894,7 +12894,8 @@ static int nl80211_tx_control_port(struc
 					 NL80211_FLAG_CHECK_NETDEV_UP)
 #define NL80211_FLAG_CLEAR_SKB		0x20

-static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
+static int nl80211_pre_doit(__genl_const struct genl_ops *ops,
+			    struct sk_buff *skb,
 			    struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev;
@@ -12956,7 +12957,8 @@ static int nl80211_pre_doit(const struct
 	return 0;
 }

-static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
+static void nl80211_post_doit(__genl_const struct genl_ops *ops,
+			      struct sk_buff *skb,
 			      struct genl_info *info)
 {
 	if (info->user_ptr[1]) {
@@ -12985,7 +12987,7 @@ static void nl80211_post_doit(const stru
 	}
 }

-static const struct genl_ops nl80211_ops[] = {
+static __genl_const struct genl_ops nl80211_ops[] = {
 	{
 		.cmd = NL80211_CMD_GET_WIPHY,
 		.doit = nl80211_get_wiphy,
