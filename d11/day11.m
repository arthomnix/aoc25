file = char (argv ()(1));

f = fopen (file, "r");
graph = containers.Map ();
nz = 0;
nodes = {};
while ((line = fgetl (f)) != -1)
  split = strsplit (line, {":", " "});
  device = char (split(1));
  connections = split(2:end);
  graph(device) = connections;
  nz += length (connections);
  nodes = union (nodes, split);
endwhile
fclose (f);

dim = length (nodes);
global adjMat;
adjMat = spalloc (dim, dim, nz);
for i = 1:dim
  node = char (nodes(i));
  if (!isKey(graph, node))
    continue
  endif

  adjNodes = graph(node);
  for adj = adjNodes
    j = find (ismember (nodes, char (adj)));
    adjMat(i, j) = 1;
  endfor
endfor

youKey = find (ismember (nodes, "you"));
outKey = find (ismember (nodes, "out"));
svrKey = find (ismember (nodes, "svr"));

global fftKey;
global dacKey;
fftKey = find (ismember (nodes, "fft"));
dacKey = find (ismember (nodes, "dac"));

function pathCount = numPaths (start, goal)
  global adjMat;
  persistent numPathsMemo = memoize (@numPaths);
  pOneMemo.CacheSize = 1e6;

  pathCount = 1;
  if (start != goal)
    pathCount = 0;
    adjNodes = find (adjMat(start,:));
    for node = adjNodes
      pathCount += numPathsMemo (node, goal);
    endfor
  endif
endfunction

function pathCount = partTwo (start, goal, foundDac, foundFft)
  global adjMat;
  global fftKey;
  global dacKey;
  persistent pTwoMemo = memoize (@partTwo);
  pTwoMemo.CacheSize = 1e6;

  pathCount = foundDac && foundFft;
  if (start != goal)
    if (start == fftKey)
      foundFft = 1;
    elseif (start == dacKey)
      foundDac = 1;
    endif

    pathCount = 0;
    adjNodes = find (adjMat(start,:));
    for node = adjNodes
      pathCount += pTwoMemo (node, goal, foundDac, foundFft);
    endfor
  endif
endfunction

partOneAnswer = numPaths (youKey, outKey);
partTwoAnswer = partTwo (svrKey, outKey, 0, 0);
printf ("%d\n%d\n", partOneAnswer, partTwoAnswer);
