
# parsetab.py
# This file is automatically generated. Do not edit.
_tabversion = '3.2'

_lr_method = 'LALR'

_lr_signature = '\xd8\xec\x13\xad1\xb3\xa9\xd5\xee=\xf8{7k\xa96'
    
_lr_action_items = {'NUMBERSEQUENCE':([1,],[3,]),'WORD':([0,],[1,]),'$end':([2,3,],[0,-1,]),}

_lr_action = { }
for _k, _v in _lr_action_items.items():
   for _x,_y in zip(_v[0],_v[1]):
      if not _x in _lr_action:  _lr_action[_x] = { }
      _lr_action[_x][_k] = _y
del _lr_action_items

_lr_goto_items = {'sentence':([0,],[2,]),}

_lr_goto = { }
for _k, _v in _lr_goto_items.items():
   for _x,_y in zip(_v[0],_v[1]):
       if not _x in _lr_goto: _lr_goto[_x] = { }
       _lr_goto[_x][_k] = _y
del _lr_goto_items
_lr_productions = [
  ("S' -> sentence","S'",1,None,None,None),
  ('sentence -> WORD NUMBERSEQUENCE','sentence',2,'p_sentence','/home/yohann/Documents/spusim/gpgpu-sim_distribution/aerialvision/lexyacc.py',219),
]
