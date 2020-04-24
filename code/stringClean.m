function c = stringClean(str)

  c = lower(erase(str,{' ', '_', ',', '''', '(', ')', '-', '*' }));

end 