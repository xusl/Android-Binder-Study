input boxes;

outputtemplate := "%j.ps";
outputformat := "ps";
%outputformat := "svg";

beginfig(1);

%定义盒子
%struct binder_proc
boxjoin(a.sw=b.nw; a.se=b.ne);
boxit.binder_proc_node(btex proc\_node etex);
boxit.binder_proc_threads(btex threads etex);
boxit.binder_proc_nodes(btex nodes etex);
boxit.binder_proc_refs_by_desc(btex refs\_by\_desc etex);
boxit.binder_proc_refs_by_node(btex refs\_by\_node etex);
boxit.binder_proc_pid(btex pid etex);
boxit.binder_proc_vma(btex vma etex);
boxit.binder_proc_tsk(btex tsk etex);
boxit.binder_proc_files(btex files etex);
boxit.binder_proc_dot1(btex \vdots etex);
boxit.binder_proc_buffer(btex buffer etex);
boxit.binder_proc_user_buffer_offset(btex user\_buffer\_offset etex);
boxit.binder_proc_buffers(btex buffers etex);
boxit.binder_proc_free_buffers(btex free\_buffers etex);
boxit.binder_proc_pages(btex pages etex);
boxit.binder_proc_buffer_size(btex buffer\_size etex);
boxit.dot2(btex \vdots etex);

%struct binder_node
boxjoin(a.sw=b.nw; a.se=b.ne);
boxit.binder_node_proc(btex proc etex);%-->binder_proc
boxit.binder_node_refs(btex refs etex);
boxit.binder_node_ptr(btex ptr etex);
boxit.binder_node_cookie(btex cookie etex);
boxit.dot3(btex \vdots etex);

%struct binder_ref
boxjoin(a.sw=b.nw; a.se=b.ne);
boxit.binder_ref_rb_node_desc(btex rb\_node\_desc etex);
boxit.binder_ref_rb_node_node(btex rb\_node\_node etex);
boxit.binder_ref_node_entry(btex node\_entry etex);
boxit.binder_ref_proc(btex proc etex);%--> binder_proc
boxit.binder_ref_node(btex node etex);%--> binder_node
boxit.binder_ref_desc(btex desc etex);
boxit.binder_ref_strong(btex strong etex);
boxit.binder_ref_weak(btex strong etex);
boxit.binder_ref_death(btex death etex);

%struct binder_thread
boxjoin(a.sw=b.nw; a.se=b.ne);
boxit.binder_(btex desc etex);

%struct binder_buffer
boxjoin(a.sw=b.nw; a.se=b.ne);

%struct binder_transaction
boxjoin(a.sw=b.nw; a.se=b.ne);
boxit.binder_transaction_work(btex work etex);
boxit.binder_transaction_from(btex *from etex);
boxit.binder_transaction_from_parent(btex *from\_parent etex);
boxit.binder_transaction_to_proc(btex to\_proc etex);
boxit.binder_transaction_to_thread(btex to\_thread etex);
boxit.binder_transaction_to_parent(btex to\_parent etex);
boxit.binder_transaction_need_reply(btex need\_reply etex);
boxit.binder_transaction_buffer(btex buffer etex);
boxit.binder_transaction_code(btex code etex);
boxit.binder_transaction_flags(btex flags etex);
boxit.binder_transaction_priority(btex priority etex);
boxit.binder_transaction_saved_priority(btex saved\_priority etex);
boxit.binder_transaction_sender_euid(btex sender\_euid etex);

%struct binder_thread
boxjoin(a.sw=b.nw; a.se=b.ne);
boxit.binder_thread_proc(btex proc etex);%-->binder_proc
boxit.binder_thread_rb_node(btex rb\_node etex);
boxit.binder_thread_pid(btex pid etex);
boxit.binder_thread_looper(btex looper etex);
boxit.binder_thread_transaction_stack(btex transaction\_stack etex);
boxit.binder_thread_dots(btex \vdots etex);
boxit.binder_thread_stats(btex stats etex);

%struct binder_buffer
boxjoin(a.sw=b.nw;a.se=b.ne);
boxit.binder_buffer_entry(btex entry etex);
boxit.binder_buffer_rb_node(btex rb\_node etex);
boxit.binder_buffer_dots(btex \vdots etex);
boxit.binder_buffer_transaction(btex transaction etex);
boxit.binder_buffer_target_node(btex target\_node etex);
boxit.binder_buffer_data_size(btex data\_size etex);
boxit.binder_buffer_offsets_size(btex offsets\_size etex);
boxit.binder_buffer_data(btex data etex);

w:=.6u;
binder_ref_rb_node_desc.dx=w;
binder_node_cookie.dx=13pt;
binder_proc_user_buffer_offset.dx=w; 
%c1.dx=8bp; 
binder_transaction_work.dx=5u;

binder_thread_transaction_stack.dx=w;
binder_buffer_transaction.dx=3*w;

%llseek1.nw = dot6.sw + (0, -u);

%c:= .6u;
%ypart count.c = ypart files.c + c;
%ypart c1.c = ypart fd.c + c;

xpart binder_proc_node.w - xpart binder_ref_rb_node_desc.e = 8u;
xpart binder_thread_proc.w - xpart binder_proc_node.e = 4u;
binder_ref_death.sw = binder_node_proc.nw + (0, 4u);
binder_node_cookie.sw = binder_buffer_entry.nw + (0, 4u);
binder_proc_buffer_size.sw = binder_transaction_work.nw + (0, 4u);


drawboxed(binder_ref_rb_node_desc, binder_ref_rb_node_node, binder_ref_node_entry,
        binder_ref_proc, binder_ref_node, binder_ref_desc, binder_ref_strong,
        binder_ref_weak, binder_ref_death);
drawboxed(binder_node_proc, binder_node_refs,binder_node_ptr, binder_node_cookie);
drawboxed(binder_proc_node, binder_proc_threads, binder_proc_nodes,
        binder_proc_refs_by_desc, binder_proc_refs_by_node, binder_proc_pid, binder_proc_vma,
        binder_proc_tsk, binder_proc_files, binder_proc_dot1, binder_proc_buffer,
        binder_proc_user_buffer_offset, binder_proc_buffers, binder_proc_free_buffers,
        binder_proc_pages, binder_proc_buffer_size);
drawboxed(binder_transaction_work, binder_transaction_from, binder_transaction_from_parent,
        binder_transaction_to_proc, binder_transaction_to_thread, binder_transaction_to_parent,
        binder_transaction_need_reply, binder_transaction_buffer, binder_transaction_code,
        binder_transaction_flags, binder_transaction_priority, binder_transaction_saved_priority,
        binder_transaction_sender_euid);
drawboxed(binder_buffer_entry, binder_buffer_rb_node, binder_buffer_dots,
        binder_buffer_transaction, binder_buffer_target_node, binder_buffer_data_size,
        binder_buffer_offsets_size, binder_buffer_data);
drawboxed(binder_thread_proc, binder_thread_rb_node, binder_thread_pid,
        binder_thread_looper, binder_thread_transaction_stack, binder_thread_dots,
        binder_thread_stats);

drawarrow (binder_node_proc.e - (.2u,0)){right}...{right}binder_proc_node.nw;
drawarrow (binder_ref_proc.e- (.2u,0)){right}...{right}binder_proc_node.nw;
%drawarrow c6.c{right}...{right}(dot4.nw+(0, -4bp));
%drawarrow (binder_ref_node.w+ (.3u,0))...(ypart binder_ref_node.w, (ypart binder_ref_node.w + ypart binder_node_proc.w) /2) ...binder_node_proc.w;
drawarrow (binder_ref_node.w+ (.3u,0))...{dir -60}binder_node_proc.w;
drawarrow (binder_buffer_transaction.e- (.2u,0)){right}...{right}binder_transaction_work.nw;
drawarrow (binder_buffer_target_node.w+ (.3u,0))...{dir 60}binder_node_proc.w;
drawarrow (binder_thread_proc.w+ (.2u,0)){left}...{left}binder_proc_node.ne;
drawarrow (binder_thread_transaction_stack.w+(.3u,0))...{dir -120}binder_transaction_work.e;
drawarrow (binder_transaction_to_parent.e) ... {dir 220}binder_transaction_work.n;

label.urt(btex struct binder\_proc etex , binder_proc_node.nw+(0,1bp));
label.urt(btex struct binder\_node etex , binder_node_proc.nw+(0,1bp));
label.urt(btex struct binder\_ref etex , binder_ref_rb_node_desc.nw+(0,1bp));
label.urt(btex struct binder\_transaction etex, binder_transaction_work.nw+(-5bp,1bp));
label.urt(btex struct binder\_buffer etex, binder_buffer_entry.nw);
label.urt(btex struct binder\_thread etex, binder_thread_proc.nw+(-3bp,0));

endfig;

bye; 
