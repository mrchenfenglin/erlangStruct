%% @author Administrator
%% @doc @todo Add description to arr.

-module(que).

%% test commit 
%% description 
%% the record is illustrate priority queue
-record(queue, {
          c = 0,
          arr = [],
          idx = 1,
          size = 0,
          init = -1
         }).
%%{capacity, arr, start, Size, Init}
%% ====================================================================
%% API functions
%% ====================================================================
-export([que/2,
         push/2,
         pop/1]).


que(C, Init) ->
    Arr = erlang:make_tuple(C, Init),
    #queue{
      c = C,
      arr = Arr,
      idx = 1,
      size = 0,
      init = Init
     }.
%%存


push(Q, Val) ->
    if
        Q#queue.size == Q#queue.c ->
            C1 = Q#queue.c * 2,
            Arr1 = erlang:make_tuple(C1, Q#queue.init),
            Arr2 = copy(Arr1, Q#queue.arr, 1, Q#queue.idx, Q#queue.c),
            Q1 = Q#queue{c = C1, arr = Arr2, idx = 1},
            push1(Q1, Val);
        true ->
            push1(Q, Val)
    end.


push1(Q, Val) ->
    I = (Q#queue.idx + Q#queue.size - 1) rem Q#queue.c + 1,
    Arr1 = erlang:setelement(I, Q#queue.arr, Val),
    Q#queue{arr = Arr1, size = Q#queue.size + 1}.


copy(To, From, Idx1, Idx2, Capacity) ->
    if
        Idx1 > Capacity ->
            To;
        true ->
            To1 = erlang:setelement(Idx1, To, erlang:element(Idx2, From)),
            copy(To1, From, Idx1 + 1, (Idx2) rem Capacity + 1, Capacity)
    end.


%%取
pop(Q) ->
    Val = element(Q#queue.idx, Q#queue.arr),
    Arr = setelement(Q#queue.idx, Q#queue.arr, Q#queue.init),
    Idx = (Q#queue.idx) rem Q#queue.c + 1,
    {Val, Q#queue{arr = Arr, idx = Idx, size = Q#queue.size - 1}}.

%% ====================================================================
%% Internal functions
%% ====================================================================
