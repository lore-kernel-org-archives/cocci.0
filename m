From: jesse.brandeburg@intel.com (Brandeburg, Jesse)
Date: Sat, 2 Dec 2017 08:03:17 +0000
Subject: [Cocci] BUG: possible parsing issue
Message-ID: <253CF818969A9240AB2054BF91F2C2BC74A93A70@ORSMSX114.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, I'm very grateful for the work on coccinelle.

I think I've found a bug in spatch, or maybe I'm just using it wrong.  I see three problems in the generated patch at the end of this mail:
1) space in replaced code: "hlist_for_each_entry ("
2) the "if statement" in the process statement S is reformatted to be *much* longer than 80 characters 
3) the comments and whitespace in the code (statement S) are all deleted

spatch version 1.0.5 compiled with OCaml version 4.02.3
Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --enable-release=yes --with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
Python scripting support: yes
Syntax of regular expresssions: PCRE


Test cocci: run below script test.cocci on following c file: spatch -sp-file test.cocci test.c
=======
@@
identifier c,member;
expression f,g;
iterator name LIST_FOR_EACH_ENTRY;
iterator name hlist_for_each_entry;
statement S;
@@

- LIST_FOR_EACH_ENTRY(c,f,g,member) S
+ hlist_for_each_entry(c,f,member) S

========
Here is the test c file:
========
static int
add_vsi_filters(struct hw *hw, u16 vsi_id,
                struct hlist_head *lkup_list_head,
                struct hlist_head *remove_list_head)
{
        struct filter_list_entry *fm_entry;

        /* check to make sure VSI id is valid and within boundary */
        if (vsi_id >=
            (sizeof(fm_entry->vsi_list_info->vsi_map) * BITS_PER_BYTE - 1))
                return -EIO;

        LIST_FOR_EACH_ENTRY(fm_entry, lkup_list_head, filter_mgmt_list_entry, list_entry) {
                struct filter_info *fi;

                fi = &fm_entry->filter_info;
                if ((fi->filter_act == FWD_TO_VSI &&
                     fi->fwd_id.vsi_id == vsi_id) ||
                    (fi->filter_act == FWD_TO_VSI_LIST &&
                     (is_bit_set(fm_entry->vsi_list_info->vsi_map, vsi_id)))) {
                        struct filter_list_entry *tmp;

                        /* this is a multi line comment that really should stay
                         * in the code to make sure things are truly awesome
                         */
                        tmp = (struct filter_list_entry *)kzalloc(sizeof(*tmp));
                        if (!tmp)
                                return -EIO;

                        memcpy(&tmp->filter_info, fi, sizeof(*fi));

                        /* This is another great big preformatted comment that
                         * should not be changed by having the code run thru
                         * coccinelle
                         */
                        if (fi->filter_act == FWD_TO_VSI_LIST) {
                                tmp->filter_info.filter_act = FWD_TO_VSI;
                                tmp->filter_info.fwd_id.vsi_id = vsi_id;
                        }

                        list_add(&tmp->list_entry, remove_list_head);
                }
        }
        return 0;
}

========

Patch output:
$ spatch --sp-file test.cocci test.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: test.c
     (ONCE) already tagged but only removed, so safe
diff =
--- test.c
+++ /tmp/cocci-output-170124-d75bd4-test.c
@@ -10,34 +10,19 @@ add_vsi_filters(struct hw *hw, u16 vsi_i
            (sizeof(fm_entry->vsi_list_info->vsi_map) * BITS_PER_BYTE - 1))
                return -EIO;

-       LIST_FOR_EACH_ENTRY(fm_entry, lkup_list_head, filter_mgmt_list_entry, list_entry) {
+       hlist_for_each_entry (fm_entry, lkup_list_head, list_entry) {
                struct filter_info *fi;
-
                fi = &fm_entry->filter_info;
-               if ((fi->filter_act == FWD_TO_VSI &&
-                    fi->fwd_id.vsi_id == vsi_id) ||
-                   (fi->filter_act == FWD_TO_VSI_LIST &&
-                    (is_bit_set(fm_entry->vsi_list_info->vsi_map, vsi_id)))) {
+               if ((fi->filter_act == FWD_TO_VSI && fi->fwd_id.vsi_id == vsi_id) || (fi->filter_act == FWD_TO_VSI_LIST && (is_bit_set(fm_entry->vsi_list_info->vsi_map, vsi_id)))) {
                        struct filter_list_entry *tmp;
-
-                       /* this memory is freed up in the caller function
-                        * once filters for this VSI are removed
-                        */
                        tmp = (struct filter_list_entry *)kzalloc(sizeof(*tmp));
                        if (!tmp)
                                return -EIO;
-
                        memcpy(&tmp->filter_info, fi, sizeof(*fi));
-
-                       /* Expected below fields to be set to FWD_TO_VSI and
-                        * the particular VSI id since we are only removing this
-                        * one VSI
-                        */
                        if (fi->filter_act == FWD_TO_VSI_LIST) {
                                tmp->filter_info.filter_act = FWD_TO_VSI;
                                tmp->filter_info.fwd_id.vsi_id = vsi_id;
                        }
-
                        list_add(&tmp->list_entry, remove_list_head);
                }
        }

--
Jesse Brandeburg
