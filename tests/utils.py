# https://stackoverflow.com/a/61416215
def duplicate_keys_to_array(ordered_pairs):
    d = {}
    for k, v in ordered_pairs:
        if k in d:
            if type(d[k]) is list:
                d[k].append(v)
            else:
                d[k] = [d[k],v]
        else:
           d[k] = v
    return d
