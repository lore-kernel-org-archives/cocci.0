From: bruce.w.allan@intel.com (Allan, Bruce W)
Date: Tue, 15 Nov 2016 19:44:16 +0000
Subject: [Cocci] transforming list types and functions/macros
Message-ID: <804857E1F29AAC47BF68C404FC60A18490FE2E8D@ORSMSX105.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm trying to transform uses of list types and functions/macros to hash-list equivalents in an out-of-tree Linux kernel module, have been able to do some transforms but have not found a solution for others and am hoping someone on this list could help.  The ones I still need help with are transforming all declarations similar to 'struct list_entry x' to 'struct hlist_node x' and all calls to list iterator macros such as 'list_for_each_entry(...) {' to 'hlist_for_each_entry(...) {'.  So, with the following:

struct foo_struct {
                struct list_entry list;
                ...
};

void foo()
{
                struct foo_struct *pos;
                ...
                list_for_each_entry(pos, &list_head, list) {
                                ...
                }

What SmPL script would transform the above to:

struct foo_struct {
                struct hlist_node list;
                ...
};

void foo()
{
                struct foo_struct *pos;
                ...
                hlist_for_each_entry(pos, &list_head, list) {
                                ...
                }

Thanks in advance for any help,
Bruce.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20161115/a396f578/attachment-0001.html>
